root.ImageButton_Framework_Android = class ImageButton_Framework_Android extends root.ImageButton_Framework
  constructor:(options = {}) ->
    options = root._.extend {}, options
    super options
    
  createBackButton: (settings) =>

  createButton: (settings) =>
    
    @button = Ti.UI.createView {
      height: Ti.UI.FILL
      width: settings.width
      top: settings.top
      right: settings.right
      bottom: settings.bottom
      left: settings.left
    }
    
    @buttonBackground = Ti.UI.createView {
      width: settings.width
      height: Ti.UI.FILL
      backgroundColor: '#000'
      opacity: 0.5
    }
    
    if settings.iconSettings?
      @icon = Ti.UI.createImageView(settings.iconSettings)
      @icon.touchEnabled = false
      @icon.zIndex = 1000
      @button.add @icon
    
    @button.add @buttonBackground
    
    @setEnabled(settings.enabled)
    
    @button
    
  setTitle: (title) =>
    
  togglePressed: =>
     
  onTouchStart: =>
  
  onTouchEnd: =>
    @options.onClick()
     
  setEnabled: (enabled) =>
    if enabled
      @button.addEventListener "click", @onTouchEnd
    else
      @button.removeEventListener "click", @onTouchEnd
