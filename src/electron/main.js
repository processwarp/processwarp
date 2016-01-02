'use strict';

var app = require('app');
var BrowserWindow = require('browser-window');
var dialog = require('dialog');
var ipc = require('electron').ipcMain;
var net = require('net');

require('crash-reporter').start();

const CONNECT_STATUS = {
  SETUP:    0,  ///< Goint to open socket.
  APPROACH: 1,  ///< Send account info, but not response yet.
  CONNECT:  2,  ///< Approach was success, able to use.
  CLOSE:    3,  ///< Disconnect from backend.
};

var mainWindow    = null;
var backendSocket = null;
var backendBuffer = new Buffer(0);
var accountInfo   = {};
var connectStatus = CONNECT_STATUS.CLOSE;
var contexts      = {};

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
  mainWindow = new BrowserWindow({
    minHeight: 400,
    minWidth: 340,
    height: 480,
    width: 480
  });
  mainWindow.loadURL('file://' + __dirname + '/index.html');

  // Open development and debug tool.
  // mainWindow.openDevTools(true);

  // Unlink BrowserWindow object when catch closed event.
  mainWindow.on('closed', function() {
    mainWindow = null;
  });
});

/**
 * On activate application and not exist window, create windown again.
 */
app.on('activate', function() {
  if (!mainWindow) {
    mainWindow = new BrowserWindow({width: 480, height: 480});
    mainWindow.loadURL('file://' + __dirname + '/index.html');

    // Unlink BrowserWindow object when catch closed event.
    mainWindow.on('closed', function() {
      mainWindow = null;
    });
  }
});

/**
 * When quit action is done in the interface, quit main process.
 * @return {void}
 */
function onActionQuit() {
  app.quit();
}
ipc.on('action_quit', onActionQuit);

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
ipc.on('action_connect', onActionConnect);

/**
 * When activate event is happen, send activate event to backend.
 */
function onActionActivate() {
  sendToBackend({
    command: 'activate'
  });
}
ipc.on('action_activate', onActionActivate);

/**
 * When open file action is done in the interface, show dialog and let user select file.
 * @return {void}
 */
function onActionOpenFile() {
  dialog.showOpenDialog(
    mainWindow,
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
	sendToBackend({
	  command: 'open_file',
	  filename: filename[0],
	});
      }
    }
  );
}
ipc.on('action_open_file', onActionOpenFile);

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
  backendSocket.on('data',    onBackendRecv);
  backendSocket.on('error',   onBackendError);

  backendSocket.connect('/tmp/pw.frontend.pipe');
}

/**
 * When connect to the backend by socket is success, send connect command with account information.
 * @return {void}
 */
function onBackendConnect() {
  console.assert(connectStatus == CONNECT_STATUS.APPROACH, connectStatus);
  
  sendToBackend({
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
 * Packet format is the same to sendToBackend method.
 * @param data {Buffer} Received data.
 * @return {void}
 */
function onBackendRecv(data) {
  backendBuffer = Buffer.concat([backendBuffer, data]);

  while (backendBuffer.length >= 4) {
    var psize = backendBuffer.readUInt32BE(0);  
    if (backendBuffer.length < 4 + psize + 1) return;
    if (backendBuffer.readUInt8(4 + psize) != 0) {
      /// @todo error
      console.assert(false, 'todo');
    }

    var packet = JSON.parse(backendBuffer.toString('utf8', 4, 4 + psize));
    backendBuffer = backendBuffer.slice(4 + psize + 1);

    switch (packet.command) {
      case 'connect_frontend': recvConnectFrontend(packet); break;
      case 'gui_command': recvGuiCommand(packet); break;
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
 * Send packet to backend.
 * Convert packet format json to string.
 * Send length, string, and '\0' as terminater.
 * @param packet {json} Packet to send to backend.
 * @return {void}
 */
function sendToBackend(packet) {
  console.assert(connectStatus != CONNECT_STATUS.CLOSE, connectStatus);

  var str = JSON.stringify(packet);
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
 * When receive connect-frontend reply, send result to window.
 * If result code is 0, send action_connect_success, otherwise action_connect_failure.
 * @param packet.result {number} Result code.
 */
function recvConnectFrontend(packet) {
  if (packet.result == 0) {
    mainWindow.webContents.send('action_connect_success');

  } else {
    mainWindow.webContents.send('action_connect_failure', packet.result);
  }
}

/**
 * When receive GUI command, call capable method to do it.
 * @param packet {object} Packet contain command string, process-id send from, and parameter.
 */
function recvGuiCommand(packet) {
  switch (packet.gui_command) {
    case 'create': guiCommandCreate(packet.pid, packet.param); break;
    case 'script': guiCommandScript(packet.pid, packet.param); break;
    default: {
      /// @todo error
      console.assert(false, 'todo');
    } break;
  }
}

/**
 * When receive 'create' GUI command, create a new frame and load default HTML.
 * The frame created is regist for contexts set with process-id.
 * @param pid {string} Process-id bundled for frame.
 * @param param {object} Not used.
 */
function guiCommandCreate(pid, param) {
  if (pid in contexts) {
    /// @todo error
    console.assert(false, 'todo');
  }

  var frame = new BrowserWindow();
  frame.on('closed', function(event) { onFrameClose(event, pid); });
  frame.loadURL('file://' + __dirname + '/frame.html');
  frame.webContents.pid = pid;
  // frame.openDevTools(true);

  var context = {};
  context.is_normal = false;
  context.script = [];
  context.frame = frame;

  contexts[pid] = context;
}

/**
 * When receive 'script' GUI command, pass scipt to frame or store if frame not finished setup.
 * @param pid {sring} Process-id send to.
 * @param param {object} Parameter contain script string.
 * @return {void}
 */
function guiCommandScript(pid, param) {
  if (!(pid in contexts)) {
    /// @todo error
    console.assert(false, 'todo');
  }

  var context = contexts[pid];

  if (context.is_normal == true) {
    context.frame.webContents.send('script', param.script);

  } else {
    // console.log('save context:' + param.script);
    context.script.push(param.script);
  }
}

/**
 * When frame was close by GUI, remove context.
 * @param event {object} Not used.
 * @param pid {string} Process-id bundled for frame.
 */
function onFrameClose(event, pid) {
  delete contexts[pid];
}

/**
 * When receive 'frame_load' command from frame, change status to normal and send scripts stored.
 * @param event {object} WebContents instance from ipc containing pid.
 * @return {void}
 */
function onFrameLoad(event) {
  var context = contexts[event.sender.pid];
  
  context.script.forEach(function(script) {
    context.frame.webContents.send('script', script);
  });
  context.is_normal = true;
  delete context['script'];
}
ipc.on('frame_load', onFrameLoad);
