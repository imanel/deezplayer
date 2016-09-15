const electron = require('electron')
const app = electron.app
const BrowserWindow = electron.BrowserWindow
const globalShortcut = electron.globalShortcut

let mainWindow

function displaySize() {
  let {width, height} = electron.screen.getPrimaryDisplay().workAreaSize
  width = Math.round(width * 0.75)
  height = Math.round(height * 0.75)
  return {width, height}
}

function registerGlobalShortcuts() {
  globalShortcut.register('MediaPlayPause', function () {
    console.log("Play/Pause pressed")
  })

  globalShortcut.register('MediaNextTrack', function () {
    console.log("Next pressed")
  })

  globalShortcut.register('MediaPreviousTrack', function () {
    console.log("Previous pressed")
  })

  globalShortcut.register('MediaStop', function () {
    console.log("Stop pressed")
  })
}

app.on('ready', function() {
  let mainWindow = new BrowserWindow(displaySize())

  mainWindow.loadURL('http://www.deezer.com')

  registerGlobalShortcuts()
})

app.on('will-quit', function () {
  globalShortcut.unregisterAll()
})
