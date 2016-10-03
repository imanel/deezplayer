{app, Menu, shell} = require('electron')

createMainMenu = ->
  template = [
    {
      label: 'Edit'
      submenu: [
        { role: 'undo' }
        { role: 'redo' }
        { type: 'separator' }
        { role: 'cut' }
        { role: 'copy' }
        { role: 'paste' }
        { role: 'pasteandmatchstyle' }
        { role: 'delete' }
        { role: 'selectall' }
      ]
    }
    {
      label: 'View'
      submenu: [
        {
          label: 'Reload'
          accelerator: 'CmdOrCtrl+R'
          click: (item, focusedWindow) -> focusedWindow.reload() if focusedWindow
        }
        {
          label: 'Back'
          accelerator: 'CmdOrCtrl+['
          click: (item, focusedWindow) -> focusedWindow.webContents.goBack() if focusedWindow
        }
        {
          label: 'Forward'
          accelerator: 'CmdOrCtrl+]'
          click: (item, focusedWindow) -> focusedWindow.webContents.goForward() if focusedWindow
        }
        { type: 'separator' }
        { role: 'resetzoom' }
        { role: 'zoomin' }
        { role: 'zoomout' }
        { type: 'separator' }
        { role: 'togglefullscreen' }
      ]
    }
    {
      role: 'window'
      submenu: [
        { role: 'minimize' }
        { role: 'close' }
      ]
    }
    {
      role: 'help'
      submenu: [ {
        label: 'Learn More'
        click: -> shell.openExternal 'https://deezplayer.imanel.org'
      } ]
    }
  ]
  if process.platform == 'darwin'
    name = app.getName()
    template.unshift
      label: name
      submenu: [
        { role: 'about' }
        { type: 'separator' }
        {
          role: 'services'
          submenu: []
        }
        { type: 'separator' }
        { role: 'hide' }
        { role: 'hideothers' }
        { role: 'unhide' }
        { type: 'separator' }
        { role: 'quit' }
      ]
    # Edit menu.
    template[1].submenu.push { type: 'separator' },
      label: 'Speech'
      submenu: [
        { role: 'startspeaking' }
        { role: 'stopspeaking' }
      ]
    # Window menu.
    template[3].submenu = [
      {
        label: 'Close'
        accelerator: 'CmdOrCtrl+W'
        role: 'close'
      }
      {
        label: 'Minimize'
        accelerator: 'CmdOrCtrl+M'
        role: 'minimize'
      }
      {
        label: 'Zoom'
        role: 'zoom'
      }
      { type: 'separator' }
      {
        label: 'Bring All to Front'
        role: 'front'
      }
    ]

  menu = Menu.buildFromTemplate template
  Menu.setApplicationMenu menu

module.exports = createMainMenu