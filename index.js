const electron = require('electron')
const app = electron.app
const BrowserWindow = electron.BrowserWindow

let mainWindow

app.on('ready', function() {
  var mainWindow = new BrowserWindow({width: 800, height: 600})

  mainWindow.loadURL('http://www.deezer.com')
})
