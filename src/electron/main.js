'use strict';

// Load modules.
import electron from 'electron';
import crypto from 'crypto';
import fs from 'fs';
import net from 'net';
import os from 'os';
import path from 'path';
import spawn from 'child_process';

// Load local modules.
import {NID, PID, MODULE} from './constant';
import PacketController from './packet_controller';

// Get inner modules.
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const dialog = electron.dialog;
const ipc = electron.ipcMain;

// Constant values.
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

const PW_PATH = path.join(__dirname, '..', '..', '..');
const ROOT_PATH = path.join(__dirname, '..');

// Load configuration.
const CONFIG = require(path.join(ROOT_PATH, 'config.json'));

var controller = null;
var backendProcess = null;
var backendPipePath = null;
var backendSocket = null;
var backendBuffer = new Buffer(0);
var connectStatus = CONNECT_STATUS.CLOSE;
var contexts = {};
var myNid = NID.NONE;
const packetController = new PacketController(MODULE.CONTROLLER);

/**
 * Quit main process when all window was closed.
 * @return {void}
 */
app.on('window-all-closed', function() {
  app.quit();
});

/**
 * Terminate backend process before quit application.
 * @return {void}
 */
app.on('will-quit', function() {
  if (backendProcess) {
    backendProcess.kill();
  }
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

  controller.loadURL('file://' + ROOT_PATH + '/controller.html');
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
  ipc.on('gui_relay_packet', onGuiRelayPacket);
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
      case 'relay_packet':
        recvRelayPacket(content);
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
  if (backendSocket) {
    backendSocket.destroy();
    backendSocket = null;
  }
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
    packetController.initialize(myNid, recvControllerPacket, sendRelayPacket);

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
  window.loadURL('file://' + ROOT_PATH + '/gui.html');
  window.webContents.pid = pid;

  var context = {};
  context.isNormal = false;
  context.packets = [];
  context.window = window;

  contexts[pid] = context;
}

/**
 * When receive a packet for fontend, pass it capable GUI module or CONTROLLER module.
 * @param {object} json A Received packet.
 * @return {void}
 */
function recvRelayPacket(json) {
  let packet = {
    packetId: json.packet_id,
    command: json.packet_command,
    mode: parseInt(json.mode, 16),
    dstModule: parseInt(json.dst_module, 16),
    srcModule: parseInt(json.src_module, 16),
    pid: json.pid,
    dstNid: json.dst_nid,
    srcNid: json.src_nid,
    content: json.content
  };

  if (packet.dstModule & MODULE.GUI) {
    relayGuiPacket(packet);
  }

  if (packet.dstModule & MODULE.CONTROLLER) {
    packetController.recv(packet);
  }
}

/**
 * When receive command for controller, call capable method to do it.
 * @param {object} packet Command packet.
 * @return {void}
 */
function recvControllerPacket(packet) {
  switch (packet.command) {
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
function relayGuiPacket(packet) {
  // Send packet to gui or store to wait if didn't connect yet.
  function sendOrPush(pid, packet) {
    var context = contexts[pid];

    if (context.isNormal) {
      context.window.webContents.send('gui_relay_packet', packet);
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
    console.assert(packet.pid in contexts);
    sendOrPush(packet.pid, packet);
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

  if (backendSocket && !backendSocket.write(buf)) {
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
 * Relay a packet to the backend.
 * @param {object} packet A packet to relay.
 */
function sendRelayPacket(packet) {
  console.assert(connectStatus === CONNECT_STATUS.CONNECT, connectStatus);

  let json = {
    command: 'relay_packet',
    packet_id: packet.packetId,
    packet_command: packet.command,
    mode: packet.mode.toString(16),
    dst_module: packet.dstModule.toString(16),
    src_module: packet.srcModule.toString(16),
    pid: packet.pid,
    dst_nid: packet.dstNid,
    src_nid: packet.srcNid,
    content: packet.content
  };

  sendData(json);
}

/**
 * Send activate command.
 * @return {void}
 */
function sendCommandActivate() {
  packetController.send({
    command: 'activate',
    isExplicit: true,
    dstModule: MODULE.SCHEDULER,
    pid: PID.BROADCAST,
    dstNid: NID.THIS,
    content: {}
  });
}

/**
 * Send require_processes_info command.
 * @return {void}
 */
function sendCommandRequireProcessesInfo() {
  packetController.send({
    command: 'require_processes_info',
    isExplicit: true,
    dstModule: MODULE.SCHEDULER,
    pid: PID.BROADCAST,
    dstNid: NID.THIS,
    content: {}
  });
}

/**
 * Execute backend process as a child process, and pass configuration data by JSON format string.
 * @return {void}
 */
function startBackend() {
  console.assert(connectStatus === CONNECT_STATUS.CLOSE, connectStatus);

  // Spawn backend process.
  backendProcess = spawn.spawn(CONFIG.BACKEND ||
                               path.join(PW_PATH, 'bin', 'processwarp'),
                               ['--subprocess']);
  // 'valgrind',
  // ['--trace-children=yes', path.join(PW_PATH, 'bin', 'processwarp'), '--subprocess']);

  // Setup stdout, stderr and event listener.
  backendProcess.stdout.setEncoding('utf8');
  backendProcess.stdout.pipe(process.stdout);
  backendProcess.stderr.setEncoding('utf8');
  backendProcess.stderr.pipe(process.stderr);

  backendProcess.on('exit', function() {
    // @todo error
    console.assert(false, 'backend process has exit.');
    connectStatus = CONNECT_STATUS.CLOSE;
  });

  // Generate configure for the backend process.
  backendPipePath = path.join(os.tmpdir(), 'pw-frontend-' + process.pid + '.pipe');
  var config = {
    server: CONFIG.SERVER,
    message: path.join(PW_PATH, 'src', 'const', 'daemon_mid_c.json'),
    node_name: CONFIG.NODE_NAME || os.hostname(),
    pipe_dir: path.join(os.tmpdir()),
    frontend_key: COMMON_KEY,
    frontend_pipe: backendPipePath,
    libs: CONFIG.LIBS || [],
    lib_filter: CONFIG.LIB_FILTER ||
    [path.join(PW_PATH, 'etc', os.platform(), 'libfilter.json')]
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
 * When receive packet from GUI module, relay it to backend.
 * @param event {object} Not used.
 * @param packet {object} A packet to relay.
 */
function onGuiRelayPacket(event, packet) {
  let json = {
    command: 'relay_packet',
    packet_id: packet.packetId,
    packet_command: packet.command,
    mode: packet.mode.toString(16),
    dst_module: packet.dstModule.toString(16),
    src_module: packet.srcModule.toString(16),
    pid: packet.pid,
    dst_nid: packet.dstNid,
    src_nid: packet.srcNid,
    content: packet.content
  };

  sendData(json);
}

/**
 * When window was close by GUI, remove context.
 * @param {object} event Not used.
 * @param {string} pid Process-id bundled for window.
 */
function onGuiClose(event, pid) {
  delete contexts[pid];
}
