electron = require('electron')
app = electron.app
BrowserWindow = electron.BrowserWindow
globalShortcut = electron.globalShortcut
path = require('path')

mainWindow = null
readyToQuit = false
willQuitApp = false

initialize = ->
  {width, height} = getDisplaySize()
  mainWindow = new BrowserWindow {
    icon: __dirname + 'icon.png',
    width: width,
    height: height,
    webPreferences: {
      plugins: true
    }
  }

  mainWindow.on 'close', (event) -> closeWindow event
  mainWindow.loadURL 'http://www.deezer.com'
  registerGlobalShortcuts()

# This hack was implemented because sometimes Flash blocks closing window.
closeWindow = (event) ->
  if readyToQuit
    app.quit()
  else if willQuitApp
    mainWindow.hide()
    unregisterGlobalShortcuts()
    runJS "dzPlayer.control.pause();"
    setInterval (->
      readyToQuit = true
      mainWindow.close()
    ), 100
  else
    event.preventDefault()
    mainWindow.hide()

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
  globalShortcut.register 'MediaPlayPause',     -> runJS "dzPlayer.control.togglePause();"
  globalShortcut.register 'MediaStop',          -> runJS "dzPlayer.control.pause();"
  globalShortcut.register 'MediaNextTrack',     -> runJS "dzPlayer.control.nextSong();"
  globalShortcut.register 'MediaPreviousTrack', -> runJS "dzPlayer.control.prevSong();"

runJS = (code) ->
  mainWindow.webContents.executeJavaScript code

unregisterGlobalShortcuts = ->
  globalShortcut.unregisterAll()

loadFlash()
app.on 'ready', -> initialize()
app.on 'activate', -> mainWindow.show()
app.on 'window-all-closed', -> app.quit() unless process.platform == 'darwin'
app.on 'before-quit', -> willQuitApp = true
app.on 'will-quit', -> unregisterGlobalShortcuts()
