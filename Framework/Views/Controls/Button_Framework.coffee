root.Button_Framework = class Button
  constructor:(options = {}) ->
    
    @settings = root._.extend({
      enabled: true
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
    
    @button = Ti.UI.createView({
      height: @startStyle("height")
      width: @startStyle("width")
      bottom: @startStyle("bottom")
      top: @startStyle("top")
      left: @startStyle("left")
      right: @startStyle("right")
      borderRadius: 3
      borderWidth: 1
      borderColor: @startStyle("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: @startStyle("gradient")
        backfillStart: false
      }
      layout: "horizontal"
    })
    
    if @startStyle("icon")
      @icon = Ti.UI.createImageView({
        image: @startStyle("icon")
        width: 20
        height: 20
        left: 5
      })
      @button.add(@icon)
    
    @label = Ti.UI.createLabel({
      color: @startStyle("labelColor")
      text: @startStyle("labelText")
      font: { fontSize: @startStyle("labelFontSize"), fontWeight: "bold" }
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @startStyle("labelShadowColor")
      textAlign: "center"
      height: Ti.UI.FILL
    })
    
    @button.add(@label)
    
    # @button.addEventListener("singletap", @settings.onClick)
    # @button.addEventListener("touchstart", @onTouchStart)
    # @button.addEventListener("touchend", @onTouchEnd)
    
    @setEnabled(@settings.enabled)
    
  onTouchStart: =>
    @button.updateLayout({
      height: @clickStyle("height")
      width: @clickStyle("width")
      bottom: @clickStyle("bottom")
      top: @clickStyle("top")
      left: @clickStyle("left")
      right: @clickStyle("right")
      borderRadius: 3
      borderWidth: 1
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
      bottom: @startStyle("bottom")
      top: @startStyle("top")
      left: @startStyle("left")
      right: @startStyle("right")
      borderRadius: 3
      borderWidth: 1
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
      @button.updateLayout({
        height: @startStyle("height")
        width: @startStyle("width")
        bottom: @startStyle("bottom")
        top: @startStyle("top")
        left: @startStyle("left")
        right: @startStyle("right")
        borderRadius: 3
        borderWidth: 1
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
        shadowColor: @startStyle("labelShadowColor")
      })
      
      @button.addEventListener("singletap", @settings.onClick)
      @button.addEventListener("touchstart", @onTouchStart)
      @button.addEventListener("touchend", @onTouchEnd)
    else
      @button.updateLayout({
        labelColor: "#ddd"
        labelShadowColor: "#999"
        borderColor: 'ddd'
        backgroundGradient: {
          type: 'linear'
          startPoint: { x: 0, y: 0 }
          endPoint: { x: 0, y: "100%" }
          colors: ["#EEE", "#DDD"]
          backfillStart: false
        }
      })
      @label.updateLayout({
        color: '#ccc'
        shadowColor: '#999'
      })
      
      @button.removeEventListener("singletap", @settings.onClick)
      @button.removeEventListener("touchstart", @onTouchStart)
      @button.removeEventListener("touchend", @onTouchEnd)
