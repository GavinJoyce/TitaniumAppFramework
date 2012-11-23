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
    
    if settings.text?
      @label = Ti.UI.createLabel {
        text: settings.text
        textAlign: "center"
        color: "#FFF"
        font: { fontSize: 20, fontWeight: "bold" }
        width: Ti.UI.SIZE
        zIndex: 1100
      }
      @button.add(@label)
    
    @button.add @buttonBackground
    
    @setEnabled(settings.enabled)
    
    @button
    
  setTitle: (title) =>
    @label.setText title
    
  togglePressed: =>
     
  onTouchStart: =>
  
  onTouchEnd: =>
    @options.onClick()
     
  setEnabled: (enabled) =>
    if @enabled != enabled
      if enabled
        @button.addEventListener "click", @onTouchEnd
        if @label?
          @label.setOpacity(1)
        if @icon?
          @icon.setOpacity(1)
        @enabled = enabled
      else
        @button.removeEventListener "click", @onTouchEnd
        if @label?
          @label.setOpacity(0.4)
        if @icon?
          @icon.setOpacity(0.4)
        @enabled = enabled
