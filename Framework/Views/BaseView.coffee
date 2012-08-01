root.BaseView = class BaseView
  constructor: (options = {}) ->
    @uiInitialised = false
    @settings = root._.extend({
      title: ''
      backgroundImage: root.app.settings.viewBackgroundImage
      backgroundRepeat: root.app.settings.viewBackgroundRepeat
      backgroundColor: root.app.settings.viewBackgroundColor
      barColor: root.app.settings.viewTitleBarColor
      fullscreen: false
    }, options)
    
    @isPortrait = (Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT)
    @isLandscape = (Ti.UI.orientation == Ti.UI.LANDSCAPE_LEFT || Ti.UI.orientation == Ti.UI.LANDSCAPE_RIGHT)
    
    @controls = []
    @window = Ti.UI.createWindow(@settings)
    @window.title = @settings.title #NOTE: GJ: do we need this?

    @spinner = Ti.UI.createActivityIndicator({
      message: "Loading...", width: Ti.UI.SIZE
      color: "#000", font: { fontSize: 18 }
    })
    @window.add(@spinner)
    
    
    @noInternetView = Ti.UI.createView({
      height: 60
      width: "100%"
      backgroundColor: "yellow"
    })
    noInternetHeader = Ti.UI.createLabel({
      text: "No Internet Connection"
      font: { fontSize: 20, fontWeight: "bold" }
      height: Ti.UI.SIZE
      top: 10
    })
    noInternetText = Ti.UI.createLabel({
      text: "A working internet connection is required to use this app"
      font: { fontSize: 18 }
      height: Ti.UI.SIZE
      bottom: 10
    })
    @noInternetView.add([ noInternetHeader, noInternetText ])
    
    
    @window.addEventListener('focus', @focus)
    @window.addEventListener('close', @onClose)
    
    Ti.App.addEventListener("forceLandscapeWindow", (e) =>
      @window.orientationModes = [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT]
    )
    
    Ti.Gesture.addEventListener("orientationchange", (e) =>
      if Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT
        @onPortrait()
      else
        @onLandscape()
    )

  focus: (e) =>
    @onInit() if !@uiInitialised
    @onFocus()
    @uiInitialised = true
    
  onInit: ->
  onFocus: ->

  showSpinner: -> @spinner.show()
  hideSpinner: -> @spinner.hide()

  show: (options = {}) =>
    if root.tabGroup
      root.tabGroup.tabs.activeTab.open(@window, options)
    else if root.navGroup
      @window.inNavGroup = true
      root.navGroup.navGroup.open(@window, options)
    else
      @open options
      
  open: (options = {}) =>
    options = root._.extend({}, options)
    @window.open(options)

  close: ->
    if @window.inNavGroup
      root.navGroup.navGroup.close(@window)
    else
      @window.close({ animated: false })
      
  onClose: ->
  
  add: (control) ->
    @window.add control
    @controls.push control
  
  clear: ->
    for control in @controls
      @window.remove control
    @controls = []
    
  click: (callback) ->
    @window.addEventListener("click", callback)
    
    
  # events for orientation changes
  onPortrait: ->
    
  onLandscape: ->
