root.ImageButton_Framework_Android = class ImageButton_Framework_Android extends root.ImageButton_Framework
  constructor:(options = {}) ->
    options = root._.extend {}, options
    super options
    
  createBackButton: (settings) =>

  createButton: (settings) =>
    @bg = "/Common/Framework/Images/Android/button-nine-patch.png"
    @bgPressed = "/Common/Framework/Images/Android/button-pressed-nine-patch.png"
    
    @button = Ti.UI.createView {
      height: Ti.UI.FILL
      width: Ti.UI.SIZE
      top: settings.top
      right: settings.right
      bottom: settings.bottom
      left: settings.left
      backgroundImage: @bg
    }
    
    if settings.iconSettings?
      @icon = Ti.UI.createImageView(settings.iconSettings)
      @icon.setLeft '7dp'
      @icon.setRight '7dp'
      @icon.touchEnabled = false
      @icon.zIndex = 1000
      @button.add @icon
    
    if settings.text?
      @label = Ti.UI.createLabel {
        left: '7dp', right: '7dp'
        text: settings.text
        textAlign: "center"
        color: "#FFF"
        font: { fontSize: '14dp', fontWeight: "bold" }
        width: Ti.UI.SIZE
        zIndex: 1100
      }
      @button.add(@label)
    
    @setEnabled(settings.enabled)
    
    @button
    
  setTitle: (title) =>
    @label.setText title
    
  togglePressed: =>
    if @button.isPressed
      @button.isPressed = false
      @button.backgroundImage = @bg
    else
      @button.isPressed = true
      @button.backgroundImage = @bgPressed
      
  onTouchStart: =>
    @button.backgroundImage = @bgPressed
    
  onTouchEnd: =>
    @options.onClick()
    @button.backgroundImage = @bg if !@button.isPressed
     
  setEnabled: (enabled) =>
    if @enabled != enabled
      if enabled
        @button.addEventListener "touchstart", @onTouchStart
        @button.addEventListener "click", @onTouchEnd
        if @label?
          @label.setOpacity(1)
        if @icon?
          @icon.setOpacity(1)
        @enabled = enabled
      else
        @button.removeEventListener "touchstart", @onTouchStart
        @button.removeEventListener "click", @onTouchEnd
        if @label?
          @label.setOpacity(0.4)
        if @icon?
          @icon.setOpacity(0.4)
        @enabled = enabled
