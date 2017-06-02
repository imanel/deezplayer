electron = require('electron')
{app, BrowserWindow, globalShortcut} = electron
path = require('path')
createMainMenu = require('./main_menu')

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
  mainWindow.loadURL 'https://www.deezer.com'
  registerGlobalShortcuts()
  createMainMenu()

# This hack was implemented because sometimes Deezer blocks closing window.
closeWindow = (event) ->
  if readyToQuit
    app.quit()
  else if willQuitApp
    mainWindow.hide()
    unregisterGlobalShortcuts()
    runJS "dzPlayer.control.pause();"
    setInterval (->
      readyToQuit = true
      try
        mainWindow.close()
    ), 100
  else if process.platform == 'darwin'
    event.preventDefault()
    mainWindow.hide()
  else
    app.quit()

getDisplaySize = ->
  {width, height} = electron.screen.getPrimaryDisplay().workAreaSize
  width = Math.round width * 0.75
  height = Math.round height * 0.75
  return {width, height}

registerGlobalShortcuts = ->
  globalShortcut.register 'MediaPlayPause',     -> runJS "dzPlayer.control.togglePause();"
  globalShortcut.register 'MediaStop',          -> runJS "dzPlayer.control.pause();"
  globalShortcut.register 'MediaNextTrack',     -> runJS "dzPlayer.control.nextSong();"
  globalShortcut.register 'MediaPreviousTrack', -> runJS "dzPlayer.control.prevSong();"

runJS = (code) ->
  mainWindow.webContents.executeJavaScript code

unregisterGlobalShortcuts = ->
  globalShortcut.unregisterAll()

app.on 'ready', -> initialize()
app.on 'activate', -> mainWindow.show()
app.on 'window-all-closed', -> app.quit() unless process.platform == 'darwin'
app.on 'before-quit', -> willQuitApp = true
app.on 'will-quit', -> unregisterGlobalShortcuts()
