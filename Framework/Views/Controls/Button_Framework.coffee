root.Button_Framework = class Button
  constructor:(options = {}) ->
    @settings = root._.extend({
      height: 30
      width: Ti.UI.SIZE
      bottom: "auto"
      top: "auto"
      left: "auto"
      right: "auto"
      borderColor: "#CCC"
      gradientFrom: "#EEE"
      gradientTo: "#DDD"
      labelColor: "#FFF"
      labelText: "Button"
      labelFont: { fontSize: 12, fontWeight: "bold" }
      labelShadowColor: "#CCC"
      onClick: () => Ti.API.info("button clicked")
    }, options)
    
    @button = Ti.UI.createView({
      height: @settings.height
      width: @settings.width
      bottom: @settings.bottom
      top: @settings.top
      left: @settings.left
      right: @settings.right
      borderRadius: 3
      borderWidth: 1
      borderColor: @settings.borderColor
      backgroundGradient: {
        type: 'linear'
        startPoint: { x: 0, y: 0 }
        endPoint: { x: 0, y: "100%" }
        colors: [ @settings.gradientFrom, @settings.gradientTo]
        backfillStart: false
      }
    })
    
    label = Ti.UI.createLabel({
      color: @settings.labelColor
      text: @settings.labelText
      font: @settings.labelFont
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @settings.labelShadowColor
      textAlign: "center"
    })
    @button.add(label)
    
    @button.addEventListener("click", @settings.onClick)