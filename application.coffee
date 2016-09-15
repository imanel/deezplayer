electron = require('electron')
app = electron.app
BrowserWindow = electron.BrowserWindow
globalShortcut = electron.globalShortcut
path = require('path')

mainWindow = null
willQuitApp = false

initialize = ->
  {width, height} = getDisplaySize()
  mainWindow = new BrowserWindow {
    width: width,
    height: height,
    webPreferences: {
      plugins: true
    }
  }

  mainWindow.on 'close', (event) ->
    if willQuitApp
      mainWindow = null
    else
      event.preventDefault()
      mainWindow.hide()

  mainWindow.loadURL 'http://www.deezer.com'

  registerGlobalShortcuts()

getDisplaySize = ->
  {width, height} = electron.screen.getPrimaryDisplay().workAreaSize
  width = Math.round width * 0.75
  height = Math.round height * 0.75
  return {width, height}

loadFlash = ->
  pluginName = switch process.platform
    when 'darwin' then 'PepperFlashPlayer.plugin'
    when 'linux'  then 'libpepflashplayer.so'
    when 'win32'  then 'pepflashplayer.dll'

  app.commandLine.appendSwitch 'ppapi-flash-path', path.join(__dirname, 'flash', pluginName)

registerGlobalShortcuts = ->
  globalShortcut.register 'MediaPlayPause',     -> console.log 'Play/Pause pressed'
  globalShortcut.register 'MediaStop',          -> console.log 'Stop pressed'
  globalShortcut.register 'MediaNextTrack',     -> console.log 'Next pressed'
  globalShortcut.register 'MediaPreviousTrack', -> console.log 'Previous pressed'

loadFlash()
app.on 'ready', -> initialize()
app.on 'activate', -> mainWindow.show()
app.on 'window-all-closed', -> app.quit() unless process.platform == 'darwin'
app.on 'before-quit', -> willQuitApp = true
app.on 'will-quit', -> globalShortcut.unregisterAll()
