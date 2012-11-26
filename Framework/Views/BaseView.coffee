root.BaseView = class BaseView
  constructor: (options = {}) ->
    @uiInitialised = false
    @settings = root._.extend({
      title: ''
      backgroundColor: root.app.settings.viewBackgroundColor
      backgroundGradient: root.app.settings.viewBackgroundGradient
      barColor: root.app.settings.viewTitleBarColor
      #backgroundImage: root.app.settings.viewBackgroundImage     # Commented out: CMC : Causing backgroundColor to fail on Android when '' | null
      viewTitleBarStyle: root.app.settings.viewTitleBarStyle
      useImageButtons: root.app.settings.useImageButtons
      orientationModes: root.app.settings.defaultOrientationModes
    }, options)
    @applyStyle()
    
    @isPortrait = (Ti.UI.orientation == Ti.UI.PORTRAIT || Ti.UI.orientation == Ti.UI.UPSIDE_PORTRAIT)
    @isLandscape = (Ti.UI.orientation == Ti.UI.LANDSCAPE_LEFT || Ti.UI.orientation == Ti.UI.LANDSCAPE_RIGHT)
    
    @controls = []

    @window = Ti.UI.createWindow(@settings)
    @window.addEventListener('focus', @focus)
    @window.addEventListener('close', @onClose)
    @window.addEventListener('blur', @onBlur)
    
    @buildLayout()
    @assignDefaultButtons()
  
  buildLayout: =>
    if Ti.Platform.osname == "android" && !@settings.isHome
      @header = root.app.create('HeaderControl', { backgroundColor: @settings.barColor, height: '50dp' })
      @window.add(@header.view)
      @content = Ti.UI.createView {
        top: '50dp'
        height: Ti.UI.FILL
        width: "100%"
      }
      @window.add(@content)
    else
      @content = Ti.UI.createView({
        height: Ti.UI.FILL
        width: "100%"
      })
      @window.add(@content)
  
  assignDefaultButtons: =>
    if @settings.useImageButtons && @settings.hasBackButton
      button = root.app.create 'ImageButton', {
        type: 'back'
        text: 'Back'
        onClick: => @close()
      }
      @window.setLeftNavButton button.view
    else if @settings.useImageButtons && @settings.hasDoneButton
      button = root.app.create 'ImageButton', {
        text: 'Done'
        onClick: => @close()
      }
      @window.setRightNavButton(button.view)
      
  applyStyle: -> #TODO: GJ: add support for different platforms
    if @settings.viewTitleBarStyle?
      if Ti.Platform.osname == 'ipad'
        @settings.barImage = "/Common/Framework/Images/iOS/TitleBar/iPad/#{@settings.viewTitleBarStyle}.png"
      else
        @settings.barImage = "/Common/Framework/Images/iOS/TitleBar/#{@settings.viewTitleBarStyle}.png"
    if @settings.style?
      if @settings.style == 'brushedMetal'
       @settings.backgroundImage = '/Common/Framework/Images/Patterns/brushedMetal.png'
       #@settings.backgroundRepeat = true #NOTE: GJ: waiting for titanium retina bug to be fixed

  focus: (e) =>
    Ti.API.info 'BaseView.focus'
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
    Ti.API.info 'BaseView.onFocus'
    
  show: (options = {}) =>
    if @settings.navGroup?
      @settings.navGroup.navGroup.open(@window, options)
    else if root.tabGroup?
      @window.inTabGroup = true
      root.tabGroup.tabs.activeTab.open(@window, options)
    else if root.navGroup?
      @window.inNavGroup = true
      root.navGroup.navGroup.open(@window, options)
    else
      @open options
    @isOpen = true
      
  open: (options = {}) =>
    options = root._.extend({}, options)
    @window.open(options)

  close: (options = {}) =>
    if @window.navGroup?
      @window.navGroup.navGroup.close(@window, options)
    else if @window.inTabGroup
      root.tabGroup.tabs.activeTab.close(@window, options)
    else if @window.inNavGroup
      root.navGroup.navGroup.close(@window, options)
    else
      @window.close(options)
    @onClose()
    @isOpen = false
      
  onClose: ->
    
  onBlur: ->
  
  add: (control) ->
    @content.add control
    @controls.push control
    
  remove: (control) ->
    @content.remove control
    @controls = root._.without(@controls, control)
  
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