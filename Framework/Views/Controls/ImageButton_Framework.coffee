root.ImageButton_Framework = class ImageButton_Framework
  constructor:(options = {}) ->
    @options = root._.extend({
      type: "flat"
      onClick: () => Ti.API.info("button clicked")
      backgroundColor: "transparent"
      enabled: true
    }, options)
    
    @bg = ""
    @bgPressed = ""
    
    if @options.type == "back"
      @view = @createBackButton(@options)
    else
      @view = @createButton(@options)
    
  createBackButton: (settings) =>
    @bg = "/Common/Framework/Images/iOS/TitleBar/Buttons/back.png"
    @bgPressed = "/Common/Framework/Images/iOS/TitleBar/Buttons/backPressed.png"

    @button = Ti.UI.createLabel({
      backgroundColor: settings.backgroundColor
      backgroundImage: @bg
      backgroundLeftCap: 15
      backgroundRightCap: 10
      height: 30
      width: Ti.UI.SIZE
      layout: "horizontal"
      top: settings.top
      right: settings.right
      bottom: settings.bottom
      left: settings.left
    })

    if settings.iconSettings?
      @icon = Ti.UI.createImageView(settings.iconSettings)
      @button.add(@icon)

    if settings.text?
      @label = Ti.UI.createLabel({
        text: settings.text
        textAlign: "center"
        left: 15
        right: 8
        color: "#FFF"
        font: { fontSize: 13, fontWeight: "bold" }
        width: Ti.UI.SIZE
        height: 28
      })
      @button.add(@label)

    @setEnabled(settings.enabled)
    
    @button

  createButton: (settings) =>
    if settings.bg
      @bg = settings.bg
    else
      @bg = "/Common/Framework/Images/iOS/TitleBar/Buttons/button.png"

    if settings.bgPressed
      @bgPressed = settings.bgPressed
    else
      @bgPressed = "/Common/Framework/Images/iOS/TitleBar/Buttons/buttonPressed.png"

    @button = Ti.UI.createLabel({
      backgroundColor: settings.backgroundColor
      backgroundImage: @bg
      backgroundLeftCap: 10
      backgroundRightCap: 10
      height: 30
      width: Ti.UI.SIZE
      layout: "horizontal"
      top: settings.top
      right: settings.right
      bottom: settings.bottom
      left: settings.left
    })

    if settings.iconSettings?
      @icon = Ti.UI.createImageView(settings.iconSettings)
      @button.add(@icon)

    if settings.text?
      @label = Ti.UI.createLabel({
        text: settings.text
        textAlign: "center"
        left: 8
        right: 8
        color: "#FFF"
        font: { fontSize: 13, fontWeight: "bold" }
        width: Ti.UI.SIZE
        height: 28
      })
      @button.add(@label)

    @setEnabled(settings.enabled)
    
    @button
    
  setTitle: (title) =>
    @label.text = title
    
  setIcon: (image) =>
    @icon.setImage(image)
    
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
    if enabled
      @button.addEventListener "touchstart", @onTouchStart
      @button.addEventListener "touchend", @onTouchEnd
      if @label?
        @label.setOpacity(1)
    else
      @button.removeEventListener "touchstart", @onTouchStart
      @button.removeEventListener "touchend", @onTouchEnd
      if @label?
        @label.setOpacity(0.4)
