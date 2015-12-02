'use strict';

var app = require('app');
var BrowserWindow = require('browser-window');
var ipc = require('electron').ipcMain;

require('crash-reporter').start();

var mainWindow = null;

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
