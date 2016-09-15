electron = require('electron')
app = electron.app
BrowserWindow = electron.BrowserWindow
globalShortcut = electron.globalShortcut

mainWindow = null
willQuitApp = false

displaySize = ->
  {width, height} = electron.screen.getPrimaryDisplay().workAreaSize
  width = Math.round width * 0.75
  height = Math.round height * 0.75
  return {width, height}

registerGlobalShortcuts = ->
  globalShortcut.register 'MediaPlayPause', ->
    console.log 'Play/Pause pressed'

  globalShortcut.register 'MediaNextTrack', ->
    console.log 'Next pressed'

  globalShortcut.register 'MediaPreviousTrack', ->
    console.log 'Previous pressed'

  globalShortcut.register 'MediaStop', ->
    console.log 'Stop pressed'

app.on 'ready', ->
  mainWindow = new BrowserWindow displaySize()

  mainWindow.on 'close', (event) ->
    if willQuitApp
      mainWindow = null
    else
      event.preventDefault()
      mainWindow.hide()

  mainWindow.loadURL 'http://www.deezer.com'

  registerGlobalShortcuts()

app.on 'window-all-closed', ->
  app.quit() if process.platform != 'darwin'

app.on 'activate', -> mainWindow.show()

app.on 'before-quit', -> willQuitApp = true

app.on 'will-quit', -> globalShortcut.unregisterAll()
