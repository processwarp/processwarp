'use strict';

var app = require('app');
var BrowserWindow = require('browser-window');
var dialog = require('dialog');
var ipc = require('electron').ipcMain;
var fs = require('fs');
var net = require('net');

require('crash-reporter').start();

const CONNECT_STATUS = {
  SETUP:    0,  ///< Goint to open socket.
  APPROACH: 1,  ///< Send account info, but not response yet.
  CONNECT:  2,  ///< Approach was success, able to use.
  CLOSE:    3,  ///< Disconnect from backend.
};

/** Modules those are target of send command. */
const MODULE = {
  MEMORY:     0,
  VM:         1,
  SCHEDULER:  2,
  CONTROLLER: 3,
  GUI:        4,
};

/** Special node-id those are used to send command. */
const NID = {
  NONE:      '',
  THIS:      '.',
  BROADCAST: '*',
  SERVER:    'server',
};

/** Special process-id those are used to send data. */
const PID = {
  BROADCAST: '*',
};

var controller    = null;
var backendSocket = null;
var backendBuffer = new Buffer(0);
var accountInfo   = {};
var configure     = null;
var connectStatus = CONNECT_STATUS.CLOSE;
var contexts      = {};
var myNid         = NID.NONE;

/**
 * Quit main process when all window was closed.
 * @return {void}
 */
app.on('window-all-closed', function() {
  if (process.platform != 'darwin')
    app.quit();
});

/**
 * On start application, create new window.
 */
app.on('ready', function() {
  readConfigure();
  initializeIpc();
  initializeController();
});

/**
 * On activate application and not exist window, create windown again.
 */
app.on('activate', function() {
  initializeController();
});

/**
 * Create controller window and bind event listhener to close.
 * @return {void}
 */
function initializeController() {
  if (controller != null) return;

  controller = new BrowserWindow({
    minHeight: 400,
    minWidth: 340,
    height: 480,
    width: 480
  });

  controller.loadURL('file://' + __dirname + '/index.html');
  controller.on('closed', function() {
    controller = null;
  });
}

/**
 * Bind IPC names and methods.
 * @return {void}
 */
function initializeIpc() {
  ipc.on('action_quit',      onActionQuit);
  ipc.on('action_connect',   onActionConnect);
  ipc.on('action_activate',  onActionActivate);
  ipc.on('action_open_file', onActionOpenFile);

  ipc.on('gui_load',          onGuiLoad);
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
 * store account infromation to connect and start connecting to the backend.
 * @param param.account {string} Accoutn ID.
 * @param param.password {string} Password.
 * @return {void}
 */
function onActionConnect(sender, param) {
  console.assert(connectStatus == CONNECT_STATUS.CLOSE, connectStatus);

  accountInfo.account  = param.account;
  accountInfo.password = param.password;

  connectBackend();
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
	  filename: filename[0],
	});
      }
    }
  );
}

/**
 * Connect to the backend by socket and set event emitter.
 * Change connect status to SETUP.
 * @return {void}
 */
function connectBackend() {
  console.assert(connectStatus == CONNECT_STATUS.CLOSE, connectStatus);

  connectStatus = CONNECT_STATUS.APPROACH;
  backendSocket = new net.Socket();

  backendSocket.on('connect', onBackendConnect);
  backendSocket.on('close',   onBackendClose);
  backendSocket.on('data',    onBackendRecvData);
  backendSocket.on('error',   onBackendError);

  backendSocket.connect(configure['frontend-pipe']);
}

/**
 * When connect to the backend by socket is success, send connect command with account information.
 * @return {void}
 */
function onBackendConnect() {
  console.assert(connectStatus == CONNECT_STATUS.APPROACH, connectStatus);
  
  sendData({
    command:  'connect_frontend',
    account:  accountInfo.account,
    password: accountInfo.password,
    type:     'gui',
  });
}

/**
 * When disconnect socket to backend, release socket and change status to CLOSE.
 * @return {void}
 */
function onBackendClose() {
  backendSocket = null;
  connectStatus = CONNECT_STATUS.CLOSE;
}

/**
 * When receive data from backend, clip packet and call capable method.
 * Concaenate stream data received yet with just now as buffer.
 * Packet format is the same to sendData method.
 * @param data {Buffer} Received data.
 * @return {void}
 */
function onBackendRecvData(data) {
  backendBuffer = Buffer.concat([backendBuffer, data]);

  while (backendBuffer.length >= 4) {
    var psize = backendBuffer.readUInt32BE(0);  
    if (backendBuffer.length < 4 + psize + 1) return;
    if (backendBuffer.readUInt8(4 + psize) != 0) {
      /// @todo error
      console.assert(false, 'todo');
    }

    var content = JSON.parse(backendBuffer.toString('utf8', 4, 4 + psize));
    backendBuffer = backendBuffer.slice(4 + psize + 1);

    switch (content.command) {
      case 'connect_frontend': recvConnectFrontend(content); break;
      case 'create': recvCreate(content); break;
      case 'relay_command': recvRelayCommand(content); break;
      default: {
	/// @todo eror
	console.assert(false, 'todo');
      } break;
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
  connectStatus = CONNECT_STATUS.CLOSE;

  console.log('connection error.');
}

/**
 * Read configuration.
 * @return {void}
 */
function readConfigure() {
  var is_next_config = false;
  var filename = false;
  process.argv.forEach(function(val, index) {
    if (val === '-f') {
      is_next_config = true;

    } else if (is_next_config) {
      is_next_config = false;
      filename = val;
    }
  });

  if (!filename) return;

  fs.readFile(filename, 'utf8', function(err, text) {
    if (err != null) {
      console.log(err);
      console.assert(false, 'todo');
    }

    configure = JSON.parse(text);
  });
}

/**
 * When receive connect-frontend reply, send result to window.
 * If result code is 0, send action_connect_success, otherwise action_connect_failure.
 * @param packet.result {number} Result code.
 */
function recvConnectFrontend(packet) {
  if (packet.result == 0) {
    myNid = packet.my_nid;
    controller.webContents.send('action_connect_success');
    sendCommandRequireProcessesInfo();

  } else {
    controller.webContents.send('action_connect_failure', packet.result);
  }
}

/**
 * When receive 'create' GUI command, create a new frame and load default HTML.
 * The frame created is regist for contexts set with process-id.
 * @param pid {string} Process-id bundled for frame.
 * @param param {object} Not used.
 */
function recvCreate(param) {
  var pid = param.pid

  console.assert(pid !== PID.BROADCAST);

  // Exists gui window for pid yet.
  if (pid in contexts) return;

  var window = new BrowserWindow();
  window.on('closed', function(event) { onGuiClose(event, pid); });
  window.loadURL('file://' + __dirname + '/frame.html');
  window.webContents.pid = pid;
  // frame.openDevTools(true);

  var context = {};
  context.is_normal = false;
  context.packets = [];
  context.window = window;

  contexts[pid] = context;
}

/**
 * When receive command for fontend, pass it capable GUI module or CONTROLLER module.
 * @param packet {object} Command packet.
 * @return {void}
 */
function recvRelayCommand(packet) {
  switch (parseInt(packet.module, 10)) {
    case MODULE.GUI:        relayGuiCommand(packet); break;
    case MODULE.CONTROLLER: recvCommand(packet);     break;
    default: {
      /// @todo drop
      console.assert(false, packet);
    }
  }
}

/**
 * When receive command for controller, call capable method to do it.
 * @param packet {object} Command packet.
 * @return {void}
 */
function recvCommand(packet) {
  switch (packet.content.command) {
    case 'processes_info': recvCommandProcessesInfo(packet.content); break;
    default: {
      /// @todo error
      console.assert(false, 'unsupport : ' + JSON.stringify(packet.content));
    } break;
  }
}

/**
 * When receive show_process_list command, relay it to renderer process.
 * @param pid {string} Not used.
 * @param param {object} Parameter containing process list.
 */
function recvCommandProcessesInfo(param) {
  if (controller == null) return;
  controller.webContents.send('show_process_list', param.processes);
}

/**
 * When receive command packet for GUI module, relay it by electron connect.
 * Push it to waiting quieue if connection is disabled.
 * @param packet Command packet to relay.
 * @return {void}
 */
function relayGuiCommand(packet) {
  // Send packet to gui or store to wait if didn't connect yet.
  function sendOrPush(pid, packet) {
    var context = contexts[pid];

    if (context.is_normal) {
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
 * @param data {object} Data content.
 * @return {void}
 */
function sendData(data) {
  if (connectStatus == CONNECT_STATUS.CLOSE) return;

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

/**
 * Send a command to other module in this node through the backend.
 * @param pid {string} Process-id bundled to command.
 * @param dstNide {string} Destination node-id.
 * @param module {int} Target module.
 * @param command {string} Command string.
 * @param param {object} Parameter for a command.
 */
function sendCommand(pid, dstNid, module, command, param) {
  param.command = command;
  sendData({
    command: 'relay_command',
    pid:     pid,
    dst_nid: dstNid,
    module:  module.toString(10),
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
 * When receive 'frame_load' command from frame, change status to normal and send scripts stored.
 * And tell event to scheduler.
 * @param event {object} WebContents instance from ipc containing pid.
 * @return {void}
 */
function onGuiLoad(event) {
  var pid     = event.sender.pid;
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
  context.is_normal = true;
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
    pid:     packet.pid,
    dst_nid: packet.dst_nid,
    module:  packet.module.toString(10),
    content: packet.content
  });
}

/**
 * When frame was close by GUI, remove context.
 * @param event {object} Not used.
 * @param pid {string} Process-id bundled for frame.
 */
function onGuiClose(event, pid) {
  delete contexts[pid];
}
