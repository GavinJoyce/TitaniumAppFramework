#https://github.com/appersonlabs/TitaniumStatusbarOverlay

root.StatusBar.StatusBarOverlay = class StatusBarOverlay
  constructor: ->
    @statusBarOverlay = require('mattapp.statusbar')
    
  flash: (message, duration = 2.5) ->
    @statusBarOverlay.postMessage(message, duration)
    
  loadingMessage: (message, duration = 2.5) ->
    @statusBarOverlay.postMessageInProgress(message, duration)
    
  finishMessage: (message, duration = 1) ->
    @statusBarOverlay.postFinishMessage(message, duration)