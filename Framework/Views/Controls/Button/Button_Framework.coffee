root.Button_Framework = class Button_Framework
  constructor:(options = {}) ->
    # Settings
    @settings = root._.extend({
      borderWidth: 1
      borderRadius: 5
      bottom: null
      enabled: true
      fontSize: 12
      height: 30
      left: null
      right: null
      text: "Button"
      top: null
      width: Ti.UI.SIZE
      onClick: () => Ti.API.info("button clicked")
    }, options)
    
    @settings.style = root._.extend({
      borderColor: "#CCC"
      gradient: ["#DDD", "#CCC"]
      labelColor: "#FFF"
      labelShadowColor: "#CCC"
    }, options.style)

    @settings.onClickStyle = root._.extend({}, options.onClickStyle)
    # /Settings
    
    @view = Ti.UI.createView({
      bottom: @settings.bottom
      height: @settings.height
      left: @settings.left
      right: @settings.right
      top: @settings.top
      width: @settings.width
      opacity: @settings.opacity
    })
    
    @disabledOverlay = Ti.UI.createView({
      height: Ti.UI.FILL
      width: Ti.UI.FILL
      backgroundColor: "#EEE"
      opacity: 0.5
      zIndex: 10
    })
    @view.add(@disabledOverlay)
    
    @view.addEventListener("singletap", () => @settings.onClick() if @view.enabled)
    @view.addEventListener("touchstart", () => @onTouchStart() if @view.enabled)
    @view.addEventListener("touchend", () => @onTouchEnd() if @view.enabled)
    
    @button = Ti.UI.createView({
      height: Ti.UI.FILL
      width: Ti.UI.FILL
      borderRadius: @settings.borderRadius
      borderWidth: @settings.borderWidth
      borderColor: @settings.style.borderColor
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @settings.style.gradient
        backfillStart: false
      }
    })
    @view.add(@button)
    
    @content = Ti.UI.createView({
      layout: 'horizontal'
      width: Ti.UI.SIZE
      height: Ti.UI.SIZE
      backgroundColor: "transparent"
    })
    
    if @settings.iconSettings
      @icon = Ti.UI.createImageView(@settings.iconSettings)
      @content.add(@icon)
    
    if @settings.text && @settings.text != ""
      @label = Ti.UI.createLabel({
        color: @settings.style.labelColor
        text: @settings.text
        font: { fontSize: @settings.fontSize, fontWeight: "bold" }
        shadowOffset: { x: 1, y: 1 }
        shadowColor: @settings.style.labelShadowColor
        textAlign: "center"
        height: Ti.UI.SIZE
        width: Ti.UI.SIZE
        backgroundColor: "transparent"
      })
      @content.add(@label)
    
    @view.add(@content)
    
    @setEnabled(@settings.enabled)
    
  onTouchStart: =>
    @button.updateLayout({
      borderColor: @settings.onClickStyle.borderColor
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @settings.onClickStyle.gradient
        backfillStart: false
      }
    })
    
    if @label
      @label.updateLayout({
        color: @settings.onClickStyle.labelColor
        shadowColor: @settings.onClickStyle.labelShadowColor
      })
    
  onTouchEnd: =>
    @button.updateLayout({
      borderColor: @settings.style.borderColor
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @settings.style.gradient
        backfillStart: false
      }
    })
    
    if @label
      @label.updateLayout({
        color: @settings.style.labelColor
        shadowColor: @settings.style.labelShadowColor
      })
      
  setEnabled: (enabled) =>
    if enabled
      @view.enabled = true
      @disabledOverlay.hide()
    else
      @view.enabled = false
      @disabledOverlay.show()
