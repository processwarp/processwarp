'use strict';

// Load constant value.
require('./constant');
const CONFIG = require('./config.json');

// Load modules.
var app = require('app');
var BrowserWindow = require('browser-window');
var crypto = require("crypto");
var dialog = require('dialog');
var fs = require('fs');
var ipc = require('electron').ipcMain;
var net = require('net');
var os = require('os');
var path = require('path');
var spawn = require('child_process').spawn;

require('crash-reporter').start();

const CONNECT_BACKEND_TIMEOUT = 10;
const COMMON_KEY = crypto.randomBytes(64).toString('hex');

const CONNECT_STATUS = {
  /** Disconnect from backend. */
  CLOSE: 0,
  /** Launching backend program / send common key to open pipe. */
  BEGIN: 1,
  /** After open pipe was success. */
  OPEN: 2,
  /** Send authenticate packet and not replied yet. */
  AUTH: 3,
  /** After authentication was succeed. */
  CONNECT: 4
};

var controller = null;
var backendProcess = null;
var backendPipePath = null;
var backendSocket = null;
var backendBuffer = new Buffer(0);
var connectStatus = CONNECT_STATUS.CLOSE;
var contexts = {};
var myNid = NID.NONE;

/**
 * Quit main process when all window was closed.
 * @return {void}
 */
app.on('window-all-closed', function() {
  app.quit();
});

/**
 * On start application, set event listener and create controller window.
 */
app.on('ready', function() {
  initializeIpc();
  initializeController();
  initializeBackend();
});

/**
 * On activate application and not exist window, create windown again.
 */
app.on('activate', function() {
  initializeController();
});

function initializeBackend() {
  console.assert(connectStatus === CONNECT_STATUS.CLOSE, connectStatus);

  startBackend();
  connectBackend(0);
}

/**
 * Create controller window and bind event listhener to close.
 * @return {void}
 */
function initializeController() {
  if (controller !== null) {
    return;
  }

  controller = new BrowserWindow({
    minHeight: 400,
    minWidth: 340,
    height: 480,
    width: 480
  });

  controller.loadURL('file://' + __dirname + '/controller.html');
  controller.on('closed', function() {
    controller = null;
  });
}

/**
 * Bind IPC names and methods.
 * @return {void}
 */
function initializeIpc() {
  ipc.on('action_quit', onActionQuit);
  ipc.on('action_connect', onActionConnect);
  ipc.on('action_activate', onActionActivate);
  ipc.on('action_open_file', onActionOpenFile);

  ipc.on('gui_load', onGuiLoad);
  ipc.on('gui_relay_command', onGuiRelayCommand);
}

/**
 * When quit action is done in the interface, quit main process.
 * @return {void}
 */
function onActionQuit() {
  app.quit();
}

/**
 * When connect action is done in the interface,
 * store account infromation to connect.
 * Start the backend process and connect to it.
 * @param {object} sender Sender window.
 * @param {object} param Parameter containing account, password.
 * @return {void}
 */
function onActionConnect(sender, param) {
  console.assert(connectStatus === CONNECT_STATUS.OPEN, connectStatus);
  sendAuthenticate(param.account, param.password);
}

/**
 * When activate event is happen, send activate command to the scheduler.
 */
function onActionActivate() {
  sendCommandActivate();
}

/**
 * When open file action is done in the interface, show dialog and let user select file.
 * @return {void}
 */
function onActionOpenFile() {
  dialog.showOpenDialog(
    controller,
    {
      title: 'Open and execute.',
      filters: [{
        name: 'LLVM-IR',
        extensions: ['ll', 'bc']
      }],
      properties: ['openFile']
    },
    function(filename) {
      if (filename && filename.length) {
        sendData({
          command: 'open_file',
          filename: filename[0]
        });
      }
    }
  );
}

/**
 * Try to connect until CONNECT_BACKEND_TIMEOUT[sec] has not passed.
 * If connect to the backend by a the pipe has success, set event listener.
 * @param {number} tryCount Count of trying to connect to backend process.
 * @return {void}
 */
function connectBackend(tryCount) {
  console.assert(connectStatus === CONNECT_STATUS.BEGIN, connectStatus);

  if (fs.existsSync(backendPipePath)) {
    backendSocket = new net.Socket();

    backendSocket.on('connect', onBackendConnect);
    backendSocket.on('close', onBackendClose);
    backendSocket.on('data', onBackendRecvData);
    backendSocket.on('error', onBackendError);

    backendSocket.connect(backendPipePath);
  } else if (tryCount < CONNECT_BACKEND_TIMEOUT) {
    setTimeout(function() {
      connectBackend(tryCount + 1);
    }, 1000);
  } else {
    // @todo error
    console.assert(false, 'connect backend failed.');
  }
}

/**
 * When connect to the backend by socket is success, send open command with frontend information.
 * @return {void}
 */
function onBackendConnect() {
  console.assert(connectStatus === CONNECT_STATUS.BEGIN, connectStatus);

  sendData({
    command: 'open',
    type: 'gui',
    key: COMMON_KEY
  });
}

/**
 * When disconnect socket to backend, release socket and change status to CLOSE.
 * @return {void}
 */
function onBackendClose() {
  backendSocket = null;
  if (connectStatus !== CONNECT_STATUS.CLOSE) {
    connectStatus = CONNECT_STATUS.BEGIN;
  }
}

/**
 * When receive data from backend, clip packet and call capable method.
 * Concaenate stream data received yet with just now as buffer.
 * Packet format is the same to sendData method.
 * @param {Buffer} data Received data.
 * @return {void}
 */
function onBackendRecvData(data) {
  backendBuffer = Buffer.concat([backendBuffer, data]);

  while (backendBuffer.length >= 4) {
    var psize = backendBuffer.readUInt32BE(0);
    if (backendBuffer.length < 4 + psize + 1) {
      return;
    }
    if (backendBuffer.readUInt8(4 + psize) !== 0) {
      // @todo error
      console.assert(false, 'todo');
    }

    var content = JSON.parse(backendBuffer.toString('utf8', 4, 4 + psize));
    backendBuffer = backendBuffer.slice(4 + psize + 1);

    switch (content.command) {
      case 'relay_command':
        recvRelayCommand(content);
        break;

      case 'open':
        recvOpen(content);
        break;

      case 'authenticate':
        recvAuthenticate(content);
        break;

      case 'create':
        recvCreate(content);
        break;

      default:
	// @todo eror
        console.assert(false, 'todo:' + content.command);
        break;
    }
  }
}

/**
 * When error is occurred on socket, close socket and change status to CLOSE.
 * @return {void}
 */
function onBackendError() {
  backendSocket.destroy();
  backendSocket = null;
  connectStatus = CONNECT_STATUS.BEGIN;

  console.log('connection error.');
}

/**
 * When receive 'authenticate' command, save my node-id and send result event to controller window.
 * @param packet.result {number} Result code.
 * @param packet.my_nid {string} Node-id for this node.
 */
function recvAuthenticate(packet) {
  console.assert(connectStatus === CONNECT_STATUS.AUTH, connectStatus);

  if (packet.result === 0) {
    myNid = packet.my_nid;
    connectStatus = CONNECT_STATUS.CONNECT;
    controller.webContents.send('action_connect_success', {
      my_nid: myNid
    });
    sendCommandRequireProcessesInfo();
  } else {
    connectStatus = CONNECT_STATUS.OPEN;
    controller.webContents.send('action_connect_failure', packet.result);
  }
}

/**
 * When receive open reply, change status.
 * @param {object} packet Receive data containgin result.
 */
function recvOpen(packet) {
  console.assert(packet.result === 0, 'Could not open pipe with backend process.');
  connectStatus = CONNECT_STATUS.OPEN;
}

/**
 * When receive 'create' GUI command, create a new GUI window and load default HTML.
 * The GUI created is regist for contexts set with process-id.
 * @param {object} param Not used.
 */
function recvCreate(param) {
  var pid = param.pid;

  console.assert(pid !== PID.BROADCAST);

  // Exists gui window for pid yet.
  if (pid in contexts) {
    return;
  }

  var window = new BrowserWindow();
  window.on('closed', function(event) {
    onGuiClose(event, pid);
  });
  window.loadURL('file://' + __dirname + '/gui.html');
  window.webContents.pid = pid;

  var context = {};
  context.isNormal = false;
  context.packets = [];
  context.window = window;

  contexts[pid] = context;
}

/**
 * When receive command for fontend, pass it capable GUI module or CONTROLLER module.
 * @param {object} packet Command packet.
 * @return {void}
 */
function recvRelayCommand(packet) {
  switch (parseInt(packet.module, 10)) {
    case MODULE.GUI:
      relayGuiCommand(packet);
      break;

    case MODULE.CONTROLLER:
      recvCommand(packet);
      break;

    default:
      // @todo drop
      console.assert(false, packet);
      break;
  }
}

/**
 * When receive command for controller, call capable method to do it.
 * @param {object} packet Command packet.
 * @return {void}
 */
function recvCommand(packet) {
  switch (packet.content.command) {
    case 'processes_info':
      recvCommandProcessesInfo(packet.content);
      break;

    default:
      // @todo error
      console.assert(false, 'unsupport : ' + JSON.stringify(packet.content));
      break;
  }
}

/**
 * When receive show_process_list command, relay it to renderer process.
 * @param {string} pid Not used.
 * @param {object} param Parameter containing process list.
 */
function recvCommandProcessesInfo(param) {
  if (controller === null) {
    return;
  }
  controller.webContents.send('show_process_list', param.processes);
}

/**
 * When receive command packet for GUI module, relay it by electron connect.
 * Push it to waiting quieue if connection is disabled.
 * @param {object} packet Command packet to relay.
 * @return {void}
 */
function relayGuiCommand(packet) {
  // Send packet to gui or store to wait if didn't connect yet.
  function sendOrPush(pid, packet) {
    var context = contexts[pid];

    if (context.isNormal) {
      context.window.webContents.send('gui_relay_command', packet);
    } else {
      context.packets.push(packet);
    }
  }

  // Send packet to all gui window or the target window.
  if (packet.pid === PID.BROADCAST) {
    for (var pid in contexts) {
      sendOrPush(pid, packet);
    }
  } else {
    if (packet.pid in contexts) {
      sendOrPush(packet.pid, packet);
    } else {
      console.assert(packet.dst_nid === NID.BROADCAST);
    }
  }
}

/**
 * Send data packet to backend.
 * Convert packet format JSON formatted string.
 * Send length, string, and '\0' as terminater.
 * @param {object} data Data content.
 * @return {void}
 */
function sendData(data) {
  var str = JSON.stringify(data);
  var len = Buffer.byteLength(str, 'utf8');
  var buf = new Buffer(4 + len + 1);
  buf.writeUInt32BE(len, 0);
  buf.write(str, 4);
  buf.writeInt8(0, 4 + len);

  if (!backendSocket.write(buf)) {
    onBackendError();
  }
}

function sendAuthenticate(account, password) {
  console.assert(connectStatus === CONNECT_STATUS.OPEN, connectStatus);

  connectStatus = CONNECT_STATUS.AUTH;
  sendData({
    command: 'authenticate',
    account: account,
    password: password
  });
}

/**
 * Send a command to other module in this node through the backend.
 * @param {string} pid Process-id bundled to command.
 * @param {string} dstNide Destination node-id.
 * @param {number} module Target module.
 * @param {string} command Command string.
 * @param {object} param Parameter for a command.
 */
function sendCommand(pid, dstNid, module, command, param) {
  console.assert(connectStatus === CONNECT_STATUS.CONNECT, connectStatus);

  param.command = command;
  sendData({
    command: 'relay_command',
    pid: pid,
    dst_nid: dstNid,
    module: module.toString(10),
    content: param
  });
}

/**
 * Send activate command.
 * @return {void}
 */
function sendCommandActivate() {
  sendCommand(PID.BROADCAST, NID.BROADCAST, MODULE.SCHEDULER, 'activate', {});
}

/**
 * Send require_processes_info command.
 * @return {void}
 */
function sendCommandRequireProcessesInfo() {
  sendCommand(PID.BROADCAST, NID.THIS, MODULE.SCHEDULER, 'require_processes_info', {});
}

/**
 * Execute backend process as a child process, and pass configuration data by JSON format string.
 * @return {void}
 */
function startBackend() {
  console.assert(connectStatus === CONNECT_STATUS.CLOSE, connectStatus);

  // Spawn backend process.
  backendProcess = spawn(CONFIG.BACKEND ||
                         path.join(__dirname, '..', '..', 'bin', 'processwarp'),
                         ['--subprocess']);

  // Setup stdout, stderr and event listener.
  backendProcess.stdout.setEncoding('utf8');
  backendProcess.stdout.on('data', function(data) {
    process.stdout.write(data);
  });

  backendProcess.stderr.setEncoding('utf8');
  backendProcess.stderr.on('data', function(data) {
    process.stderr.write(data);
  });

  backendProcess.on('exit', function() {
    // @todo error
    connectStatus = CONNECT_STATUS.CLOSE;
  });

  // Generate configure for the backend process.
  backendPipePath = path.join(os.tmpdir(), 'pw-frontend-' + process.pid + '.pipe');
  var config = {
    server: CONFIG.SERVER,
    message: path.join(__dirname, '..', 'const', 'daemon_mid_c.json'),
    node_name: CONFIG.NODE_NAME || os.hostname(),
    worker_pipe: path.join(os.tmpdir(), 'pw-worker-' + process.pid + '.pipe'),
    frontend_key: COMMON_KEY,
    frontend_pipe: backendPipePath,
    libs: CONFIG.LIBS || [],
    lib_filter: CONFIG.LIB_FILTER ||
    [path.join(__dirname, '..', '..', 'etc', os.platform(), 'libfilter.json')]
  };

  // Pass configure.
  backendProcess.stdin.write(JSON.stringify(config));
  connectStatus = CONNECT_STATUS.BEGIN;
}

/**
 * When receive 'gui_load' command from GUI window, change status to normal and send scripts stored.
 * And tell event to scheduler.
 * @param event {object} WebContents instance from ipc containing pid.
 * @return {void}
 */
function onGuiLoad(event) {
  var pid = event.sender.pid;
  var context = contexts[pid];

  // Send property.
  context.window.webContents.send('gui_property', {
    pid: pid,
    nid: myNid
  });

  // Send waiting packets.
  context.packets.forEach(function(packet) {
    context.window.webContents.send('gui_relay_command', packet);
  });
  context.isNormal = true;
  delete context['packets'];
}

/**
 * When receive command from GUI module, relay it to backend.
 * @param event {object} Not used.
 * @param packet {object} Command packet to relay.
 */
function onGuiRelayCommand(event, packet) {
  sendData({
    command: 'relay_command',
    pid: packet.pid,
    dst_nid: packet.dst_nid,
    module: packet.module.toString(10),
    content: packet.content
  });
}

/**
 * When window was close by GUI, remove context.
 * @param {object} event Not used.
 * @param {string} pid Process-id bundled for window.
 */
function onGuiClose(event, pid) {
  delete contexts[pid];
}
