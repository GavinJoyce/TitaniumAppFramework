root.Button_Framework = class Button
  constructor:(options = {}) ->
    
    @settings = root._.extend({
      enabled: true
      borderRadius: 3
      opacity: 1.0
      onClick: () => Ti.API.info("button clicked")
    }, options)
    @settings.style = root._.extend({
      borderColor: "#CCC"
      gradient: ["#EEE", "#DDD"]
      labelColor: "#FFF"
      labelShadowColor: "#CCC"
      height: 30
      width: Ti.UI.SIZE
      bottom: null
      top: null
      left: null
      right: null
      labelText: "Button"
      labelFontSize: 12
    }, options.style)
    @settings.onClickStyle = root._.extend({
      
    }, options.onClickStyle)
    
    @view = Ti.UI.createView({
      height: @startStyle("height")
      width: @startStyle("width")
      bottom: @startStyle("bottom")
      top: @startStyle("top")
      left: @startStyle("left")
      right: @startStyle("right")
      backgroundColor: "transparent"
    })
    
    @button = Ti.UI.createView({
      height: @startStyle("height")
      width: @startStyle("width")
      borderRadius: @settings.borderRadius
      borderWidth: 1
      borderColor: @startStyle("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @startStyle("gradient")
        backfillStart: false
      }
      opacity: @settings.opacity
      zIndex: 1
    })
    @view.add(@button)
    
    @content = Ti.UI.createView({
      layout: 'horizontal'
      width: Ti.UI.SIZE
      height: Ti.UI.SIZE
      backgroundColor: "transparent"
      zIndex: 2
    })
    
    if @startStyle("iconSettings")
      @icon = Ti.UI.createImageView(@startStyle("iconSettings"))
      @content.add(@icon)
    
    if @startStyle("labelText") && @startStyle("labelText") != ""
      @label = Ti.UI.createLabel({
        color: @startStyle("labelColor")
        text: @startStyle("labelText")
        font: { fontSize: @startStyle("labelFontSize"), fontWeight: "bold" }
        shadowOffset: { x: 1, y: 1 }
        shadowColor: @startStyle("labelShadowColor")
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
      height: @clickStyle("height")
      width: @clickStyle("width")
      borderColor: @clickStyle("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @clickStyle("gradient")
        backfillStart: false
      }
    })
    
    @label.updateLayout({
      color: @clickStyle("labelColor")
      text: @clickStyle("labelText")
      font: @clickStyle("labelFont")
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @clickStyle("labelShadowColor")
      textAlign: "center"
    })
    
  onTouchEnd: =>
    @button.updateLayout({
      height: @startStyle("height")
      width: @startStyle("width")
      borderColor: @startStyle("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @startStyle("gradient")
        backfillStart: false
      }
    })
    
    @label.updateLayout({
      color: @startStyle("labelColor")
      text: @startStyle("labelText")
      font: @startStyle("labelFont")
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @startStyle("labelShadowColor")
      textAlign: "center"
    })
    
    
  startStyle: (param) =>
    if @settings.style[param] == null
      null
    else
      @settings.style[param]
    
  clickStyle: (param) =>
    if @settings.onClickStyle[param] == null
      if @settings.style[param]
        @settings.style[param]
      else
        null
    else
      @settings.onClickStyle[param]
      
  setEnabled: (enabled) =>
    if enabled
      @view.addEventListener("singletap", @settings.onClick)
      @view.addEventListener("touchstart", @onTouchStart)
      @view.addEventListener("touchend", @onTouchEnd)
    else
      @view.removeEventListener("singletap", @settings.onClick)
      @view.removeEventListener("touchstart", @onTouchStart)
      @view.removeEventListener("touchend", @onTouchEnd)
