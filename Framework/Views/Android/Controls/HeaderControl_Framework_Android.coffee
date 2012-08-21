root.HeaderControl_Framework_Android = class HeaderControl_Framework_Android
  constructor: (options = {}) ->
    options = root._.extend({
      title: ""
      rightButtonImage: null
      rightButtonClick: () =>
      backButtonEnabled: true
      onBack: () =>
    }, options)

    @view = Ti.UI.createView({
      backgroundColor: "#151515"
      width: "100%"
      height: 50
      top: 0
    })
    
    # Left
    @left = Ti.UI.createView({
      left: 0
      width: 80
      height: 30
      layout: "horizontal"
    })

    if options.backButtonEnabled
      @backButton = Ti.UI.createImageView({
        left: 10
        height: 30
        width: 30
        image: null
        backgroundColor: "#EEE"
      })
      @backButton.addEventListener("click", options.onBack)
      @left.add(@backButton)
      
    if options.icon
      @left.add(@createIcon(options.icon, @backButton != undefined))
    # End Left
      
    # Center
    @center = Ti.UI.createView({
      height: 30
      left: 85
      right: 85
    })
    
    @title = Ti.UI.createLabel({
      text: options.title
      color: "#FFF"
      shadowOffset: { x: 1, y: 1 }
      shadowColor: "#000"
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
    
    if options.rightButtons
      for button in options.rightButtons
        Ti.API.info(button)
        #@right.add(@createRightButton(button))
    # End Right
        
    @view.add(@left)
    @view.add(@center)
    @view.add(@right)
    
  updateTitle: (title) ->
    @title.text = title
    
  createIcon: (icon, hasBackButton) =>
    newIcon = Ti.UI.createImageView({
      image: icon
      height: 30
      width: 30
      left: 10
    })
    if hasBackButton
      newIcon.addEventListener("click", options.onBack)
    newIcon
    
  createRightButton: (button) ->
    rightButton = Ti.UI.createView({
      #image: button.image
      right: 10
      height: 30
      width: 30
    })
    rightButton.addEventListener("click", button.onClick)
    rightButton
