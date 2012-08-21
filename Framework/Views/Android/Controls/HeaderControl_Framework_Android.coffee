root.HeaderControl_Framework_Android = class HeaderControl_Framework_Android
  constructor: (options = {}) ->
    @options = root._.extend({
      title: ""
      rightButtonImage: null
      rightButtonClick: () =>
      backButtonEnabled: true
      backButtonImage: "/Common/Framework/Images/Android/lightBack.png"
      onBack: () =>
      backgroundColor: "#333"
      backgroundImage: null
      textColor: "#FFF"
      shadowColor: "#000"
    }, options)

    @view = Ti.UI.createView({
      width: "100%"
      height: 50
      top: 0
    })
    if @options.backgroundImage
      @view.backgroundImage = @options.backgroundImage
      @view.backgroundRepeat = true
    else
      @view.backgroundColor = @options.backgroundColor
    
    # Left
    @left = Ti.UI.createView({
      left: 0
      width: 80
      height: 30
      layout: "horizontal"
    })

    if @options.backButtonEnabled
      @backButton = @createBackButton(@options.backButtonImage, @options.onBack)
      @left.add(@backButton)
      
    if @options.icon
      icon = @createIcon(@options.icon, @backButton != undefined)
      @left.add(icon)
    # End Left
      
    # Center
    @center = Ti.UI.createView({
      height: 30
      left: 85
      right: 85
    })
    
    @title = Ti.UI.createLabel({
      text: @options.title
      color: @options.textColor
      shadowOffset: { x: 1, y: 1 }
      shadowColor: @options.shadowColor
    })
    @center.add(@title)
    # End Center
    
    # Right
    @right = Ti.UI.createView({
      right: 0
      width: 80
      height: 30
      layout: "horizontal"
    })
    
    if @options.rightButtons
      for button in @options.rightButtons
        newButton = @createRightButton(button)
        @right.add(newButton)
    # End Right
        
    @view.add(@left)
    @view.add(@center)
    @view.add(@right)
    
  updateTitle: (title) ->
    @title.text = title
    
  createBackButton: (image, onBack) =>
    back = Ti.UI.createImageView({
      left: 10
      height: 30
      width: 30
      image: image
    })
    back.addEventListener("click", onBack)
    back
    
  createIcon: (icon, hasBackButton) =>
    newIcon = Ti.UI.createImageView({
      image: icon
      height: 30
      width: 30
      left: 10
    })
    #if hasBackButton
      #newIcon.addEventListener("click", @options.onBack)
    newIcon
    
  createRightButton: (button) =>
    rightButton = Ti.UI.createView({
      image: button.image
      right: 10
      height: 30
      width: 30
    })
    rightButton.addEventListener("click", button.onClick)
    rightButton
