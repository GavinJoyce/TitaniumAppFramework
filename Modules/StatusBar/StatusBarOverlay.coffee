#https://github.com/appersonlabs/TitaniumStatusbarOverlay

root.StatusBar.StatusBarOverlay = class StatusBarOverlay
  constructor: ->
    @statusBarOverlay = require('mattapp.statusbar')
    
  flash: (message, duration = 2.5) =>
    @statusBarOverlay.postMessage(message, duration)
    
  loadingMessage: (message, duration) =>
    @statusBarOverlay.postMessageInProgress(message, duration)
    
  finishMessage: (message, duration = 1) =>
    @statusBarOverlay.postFinishMessage(message, duration)
    
  errorMessage: (message, duration = 1) =>
    @statusBarOverlay.postErrorMessage(message, duration)
  
  hide: => @statusBarOverlay.hide()
  
  show: => @statusBarOverlay.show()
    
  clear: => @statusBarOverlay.stop()