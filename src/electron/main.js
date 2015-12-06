'use strict';

var app = require('app');
var BrowserWindow = require('browser-window');
var ipc = require('electron').ipcMain;
var net = require('net');

require('crash-reporter').start();

const CONNECT_STATUS = {
  NONE:    0,  ///< Not connected, contain error, disconnect.
  SIGNIN:  1,  ///< Send account info, but not response yet.
  CONNECT: 2,  ///< Sign in was success and able to use.
};

var mainWindow    = null;
var daemonSocket  = null;
var accountInfo   = {};
var connectStatus = CONNECT_STATUS.NONE;

/**
 * C assertion like function.
 * Quit main process when condition is not true.
 * @param condition {bool}
 * @return {void}
 */
function assert(condition) {
  if (!condition) {
    console.log('assertion failed!');
    app.quit();
  }
}

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
  mainWindow = new BrowserWindow({width: 480, height: 480});
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
 * On receive quit command from window, quit main process.
 * @return {void}
 */
function onQuit() {
  app.quit();
}
ipc.on('quit', onQuit);

/**
 * On receive connect command from window, connect with daemon and send account infromation to sign-in.
 * @param param.account {string} Accoutn ID.
 * @param param.password {string} Password.
 * @return {void}
 */
function onConnect(sender, param) {
  assert(connectStatus == CONNECT_STATUS.NONE);

  accountInfo.account  = param.account;
  accountInfo.password = param.password;

  connectDaemon();
}
ipc.on('connect', onConnect);

/**
 * Connect to the daemon using pipe and set event emitter.
 * @return {void}
 */
function connectDaemon() {
  assert(connectStatus == CONNECT_STATUS.NONE);

  daemonSocket = new net.Socket();

  daemonSocket.on('connect', onConnectDaemon);
  daemonSocket.on('close',   onCloseConnection);
  daemonSocket.on('error',   onErrorConnection);

  daemonSocket.connect('/tmp/pw.frontend.pipe');
}

/**
 * On connecting with daemon, send signin command and change status to SINGIN.
 * Change status before call sendToDaemon, because sendToDaemon raise error if status is NONE.
 * @return {void}
 */
function onConnectDaemon() {
  assert(connectStatus == CONNECT_STATUS.NONE);
  
  connectStatus = CONNECT_STATUS.SIGNIN;
  sendToDaemon({
    command:  'signin',
    account:  accountInfo.account,
    password: accountInfo.password,
    type:     'gui',
  });
}

/**
 * On closeing connection with daemon, release socket and change status to NONE.
 * @return {void}
 */
function onCloseConnection() {
  assert(connectStatus != CONNECT_STATUS.NONE);
  
  daemonSocket  = null;
  connectStatus = CONNECT_STATUS.NONE;
}

/**
 * On error was happen, close socket.
 * @return {void}
 */
function onErrorConnection() {
  assert(connectStatus != CONNECT_STATUS.NONE);

  daemonSocket.destroy();
  daemonSocket  = null;
  connectStatus = CONNECT_STATUS.NONE;

  console.log('connection error.');
}

/**
 * Send packet to daemon.
 * Convert packet format json to string.
 * Send length, string, and '\0' as terminater.
 * @param packet {json} Packet to send to daemon.
 * @return {void}
 */
function sendToDaemon(packet) {
  assert(connectStatus != CONNECT_STATUS.NONE);

  var str = JSON.stringify(packet);
  var len = Buffer.byteLength(str, 'utf8');
  var buf = new Buffer(4 + len + 1);
  buf.writeUInt32BE(len, 0);
  buf.write(str, 4);
  buf.writeInt8(0, 4 + len);

  if (!daemonSocket.write(buf)) {
    onErrorConnection();
  }
}
