root.Button_Framework = class Button
  constructor:(options = {}) ->
    @settings = root._.extend({
      height: 30
      width: Ti.UI.SIZE
      bottom: null
      top: null
      left: null
      right: null
      borderColor: "#CCC"
      gradientFrom: "#EEE"
      gradientTo: "#DDD"
      labelColor: "#FFF"
      labelText: "Button"
      labelFontSize: 12
      labelShadowColor: "#CCC"
      onClick: () => Ti.API.info("button clicked")
    }, options)
    
    @button = Ti.UI.createView({
      height: @startValue("height")
      width: @startValue("width")
      bottom: @startValue("bottom")
      top: @startValue("top")
      left: @startValue("left")
      right: @startValue("right")
      borderRadius: 3
      borderWidth: 1
      borderColor: @startValue("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: [ @startValue("gradientFrom"), @startValue("gradientTo")]
        backfillStart: false
      }
    })
    
    @label = Ti.UI.createLabel({
      color: @startValue("labelColor")
      text: @startValue("labelText")
      font: { fontSize: @startValue("labelFontSize"), fontWeight: "bold" }
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @startValue("labelShadowColor")
      textAlign: "center"
    })
    @button.add(@label)
    
    @button.addEventListener("singletap", @settings.onClick)
    @button.addEventListener("touchstart", @onTouchStart)
    @button.addEventListener("touchend", @onTouchEnd)
    
  onTouchStart: =>
    @button.updateLayout({
      height: @clickValue("height")
      width: @clickValue("width")
      bottom: @clickValue("bottom")
      top: @clickValue("top")
      left: @clickValue("left")
      right: @clickValue("right")
      borderRadius: 3
      borderWidth: 1
      borderColor: @clickValue("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: [ @clickValue("gradientFrom"), @clickValue("gradientTo")]
        backfillStart: false
      }
    })
    
    @label.updateLayout({
      color: @clickValue("labelColor")
      text: @clickValue("labelText")
      font: @clickValue("labelFont")
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @clickValue("labelShadowColor")
      textAlign: "center"
    })
    
  onTouchEnd: =>
    @button.updateLayout({
      height: @startValue("height")
      width: @startValue("width")
      bottom: @startValue("bottom")
      top: @startValue("top")
      left: @startValue("left")
      right: @startValue("right")
      borderRadius: 3
      borderWidth: 1
      borderColor: @startValue("borderColor")
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: [ @startValue("gradientFrom"), @startValue("gradientTo")]
        backfillStart: false
      }
    })
    
    @label.updateLayout({
      color: @startValue("labelColor")
      text: @startValue("labelText")
      font: @startValue("labelFont")
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @startValue("labelShadowColor")
      textAlign: "center"
    })
    
    
  startValue: (param) =>
    if @settings[param] == null
      null
    else
      if typeof @settings[param] == "object"
        @settings[param][0]
      else
        @settings[param]
    
  clickValue: (param) =>
    if @settings[param] == null
      null
    else
      if typeof @settings[param] == "object"
        if @settings[param][1]
          @settings[param][1]
        else
          @settings[param][0]
      else
        @settings[param]