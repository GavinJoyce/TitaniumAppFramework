root.BaseView = class BaseView
  constructor: (options = {}) ->
    @uiInitialised = false
    @settings = root._.extend({
      title: ''
      backgroundColor: root.app.settings.viewBackgroundColor
      backgroundGradient: root.app.settings.viewBackgroundGradient
      barColor: root.app.settings.viewTitleBarColor
      barImage: root.app.settings.viewTitleBarImage
      backgroundImage: root.app.settings.viewBackgroundImage
      barImage: root.app.settings.barImage
      #fullscreen: false
      #modal: false
    }, options)
    @isPortrait = (Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT)
    @isLandscape = (Ti.UI.orientation == Ti.UI.LANDSCAPE_LEFT || Ti.UI.orientation == Ti.UI.LANDSCAPE_RIGHT)
    
    @controls = []

    @window = Ti.UI.createWindow(@settings)
    
    @window.addEventListener('focus', @focus)
    @window.addEventListener('close', @onClose)
    
    @content = Ti.UI.createView({
      height: Ti.UI.FILL
      width: "100%"
    })
    @window.add(@content)
    

  focus: (e) =>
    @onInit() if !@uiInitialised
    @onFocus()
    @uiInitialised = true
    
  onInit: ->
    Ti.App.addEventListener("forceLandscapeWindow", (e) => @window.orientationModes = [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT])
    Ti.Gesture.addEventListener("orientationchange", (e) =>
      if Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT
        @isPortrait = true
        @isLandscape = false
        @onPortrait()
      else
        @isLandscape = true
        @isPortrait = false
        @onLandscape()
    )
    
    if @isPortrait
      @onPortrait()
    if @isLandscape
      @onLandscape()
      
  onFocus: ->

  show: (options = {}) =>
    if root.tabGroup
      @window.inTabGroup = true
      root.tabGroup.tabs.activeTab.open(@window, options)
    else if root.navGroup
      @window.inNavGroup = true
      root.navGroup.navGroup.open(@window, options)
    else
      @open options
      
  open: (options = {}) =>
    options = root._.extend({}, options)
    @window.open(options)

  close: (options = {}) =>
    if @window.inTabGroup
      root.tabGroup.tabs.activeTab.close(@window, options)
    else if @window.inNavGroup
      root.navGroup.navGroup.close(@window, options)
    else
      @window.close(options)
    @onClose()
      
  onClose: ->
  
  add: (control) ->
    @content.add control
    @controls.push control
  
  clear: ->
    for control in @controls
      @content.remove control
    @controls = []
    
  click: (callback) ->
    @window.addEventListener("click", callback)
    
    
  # events for orientation changes
  onPortrait: ->
    
  onLandscape: ->

  addHeader: (header) ->
    @window.add(header)
    @content.top = header.height