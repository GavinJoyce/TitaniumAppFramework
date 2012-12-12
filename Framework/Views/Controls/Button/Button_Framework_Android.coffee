root.Button_Framework_Android = class Button_Framework_Android extends root.Button_Framework
  constructor:(options = {}) ->
    options = root._.extend {}, options
    # super options
    
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
    
    @view = Ti.UI.createView({
      bottom: @settings.bottom
      height: @settings.height
      left: @settings.left
      right: @settings.right
      top: @settings.top
      width: @settings.width
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
        textAlign: "center"
        height: Ti.UI.SIZE
        width: Ti.UI.SIZE
        backgroundColor: "transparent"
      })
      @content.add(@label)
    
    @view.add(@content)
    
    @setEnabled(@settings.enabled)
    
  onTouchStart: =>
    if @label
      @label.updateLayout {
        color: @settings.onClickStyle.labelColor
      }
    
  onTouchEnd: =>
    if @label
      @label.updateLayout {
        color: @settings.style.labelColor
      }

  