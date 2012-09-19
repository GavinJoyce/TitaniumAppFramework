root.ImageButton_Framework = class ImageButton_Framework
  constructor:(options = {}) ->
    options = root._.extend({
      type: "flat"
    }, options)
    
    Ti.API.info(options)
    
    if options.type == "back"
      @view = @createBackButton(options)
    else
      @view = @createButton(options)
    
  createBackButton: (settings) =>
    bg = "/Common/Framework/Images/iOS/TitleBar/Buttons/back.png"
    bgPressed = "/Common/Framework/Images/iOS/TitleBar/Buttons/backPressed.png"

    button = Ti.UI.createLabel({
      backgroundImage: bg
      backgroundLeftCap: 20
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
      icon = Ti.UI.createImageView(settings.iconSettings)
      button.add(icon)

    if settings.text?
      label = Ti.UI.createLabel({
        text: settings.text
        textAlign: "center"
        left: 13
        right: 8
        color: "#FFF"
        font: { fontSize: 13, fontWeight: "bold" }
        width: Ti.UI.SIZE
        height: 28
      })
      button.add(label)

    button.addEventListener("touchstart", () => button.backgroundImage = bgPressed)
    button.addEventListener("touchend", () => button.backgroundImage = bg)
    button

  createButton: (settings) =>
    bg = ""
    bgPressed = ""

    switch settings.color
      when "red"
        bg = "/Common/Framework/Images/iOS/TitleBar/Buttons/red.png"
        bgPressed = "/Common/Framework/Images/iOS/TitleBar/Buttons/redPressed.png"
      when "blue"
        bg = "/Common/Framework/Images/iOS/TitleBar/Buttons/blue.png"
        bgPressed = "/Common/Framework/Images/iOS/TitleBar/Buttons/bluePressed.png"

    button = Ti.UI.createLabel({
      backgroundImage: bg
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
      icon = Ti.UI.createImageView(settings.iconSettings)
      button.add(icon)

    if settings.text?
      label = Ti.UI.createLabel({
        text: settings.text
        textAlign: "center"
        left: 8
        right: 8
        color: "#FFF"
        font: { fontSize: 13, fontWeight: "bold" }
        width: Ti.UI.SIZE
        height: 28
      })
      button.add(label)

    button.addEventListener("touchstart", () => button.backgroundImage = bgPressed)
    button.addEventListener("touchend", () => button.backgroundImage = bg)
    button