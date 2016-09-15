const electron = require('electron')
const app = electron.app
const BrowserWindow = electron.BrowserWindow

let mainWindow

function displaySize() {
  let {width, height} = electron.screen.getPrimaryDisplay().workAreaSize
  width = Math.round(width * 0.75)
  height = Math.round(height * 0.75)
  return {width, height}
}

app.on('ready', function() {
  let mainWindow = new BrowserWindow(displaySize())

  mainWindow.loadURL('http://www.deezer.com')
})
