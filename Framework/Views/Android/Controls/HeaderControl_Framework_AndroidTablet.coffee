root.HeaderControl_Framework_AndroidTablet = class HeaderControl_Framework_AndroidTablet extends root.HeaderControl_Framework_Android
  constructor: (options = {}) ->
    @options = root._.extend({}, options)
    super(@options)

    @view.height = 70
    
    @title.font = { fontSize: 22, fontWeight: "bold" }
    
    @center.height = 50
    @center.left = 125
    @center.right = 125
      
    @right.width = 120
    @right.height = 50
    
  createLeftArea: =>
    Ti.UI.createView({
      left: 10
      width: 110
      height: 50
      layout: "horizontal"
    })

  createBackButton: (image, onBack) =>
    back = Ti.UI.createImageView({
      right: 10
      height: 50
      width: 50
      image: image
    })
    back.addEventListener("click", onBack)
    back

  createIcon: (iconUrl, hasBackButton) =>
    Ti.API.info("in here")

    newIcon = Ti.UI.createImageView({
      image: iconUrl
      height: 50
      width: 51
    })
    if hasBackButton
      newIcon.addEventListener("click", @options.onBack)
    newIcon

  createRightButton: (button) =>
    rightButton = Ti.UI.createImageView({
      image: button.image
      right: 10
      height: 50
      width: 50
    })
    rightButton.addEventListener("click", button.onClick)
    rightButton
