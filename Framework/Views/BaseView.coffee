root.BaseView = class BaseView
  constructor: (options = {}) ->
    @uiInitialised = false
    @settings = root._.extend({ #TODO: GJ: can we pass in isModal?
      title: ''
      backgroundImage: root.app.settings.viewBackgroundImage
      backgroundRepeat: root.app.settings.viewBackgroundRepeat
      backgroundColor: root.app.settings.viewBackgroundColor
      backgroundGradient: root.app.settings.viewBackgroundGradient
      barColor: root.app.settings.viewTitleBarColor
      fullscreen: false
      modal: false
    }, options)
    @isPortrait = (Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT)
    @isLandscape = (Ti.UI.orientation == Ti.UI.LANDSCAPE_LEFT || Ti.UI.orientation == Ti.UI.LANDSCAPE_RIGHT)
    
    @controls = []

    @window = Ti.UI.createWindow(@settings)

    
    #TODO: SS: perhaps this should be a modal view on the app itself? we don't want every view to have this overhead
    ###@noInternetView = Ti.UI.createView({ #TODO: GJ: move to NoInternetView class
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
    @noInternetView.add([ noInternetHeader, noInternetText ])###
    
    @window.addEventListener('focus', @focus)
    @window.addEventListener('close', @onClose)
    

  focus: (e) =>
    @onInit() if !@uiInitialised
    @onFocus()
    @uiInitialised = true
    
  onInit: ->
    @spinner = Ti.UI.createActivityIndicator({
      message: "Loading...", width: Ti.UI.SIZE
      color: "#000", font: { fontSize: 18 }
    })
    @window.add(@spinner)
    
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
    
    if Ti.Platform.osname == "ipad" #NOTE: GJ: shouldn't we trigger this regardless of the platform?
      if @isPortrait
        @onPortrait()
      if @isLandscape
        @onLandscape()
      
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
