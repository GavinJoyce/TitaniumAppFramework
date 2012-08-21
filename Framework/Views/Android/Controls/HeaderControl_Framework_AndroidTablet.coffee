root.HeaderControl_Framework_AndroidTablet = class HeaderControl_Framework_AndroidTablet extends root.HeaderControl_Framework_Android
  constructor: (options = {}) ->
    options = root._.extend({}, options)
    super(options)

    @view.backgroundColor = "#EDEDED"
    @view.height = 70
    
    @title.font = { fontSize: 22, fontWeight: "bold" }
    @title.color = "#333"
    @title.shadowColor = "#FFF"
    
    @left.width = 120
    @left.height = 50
    
    if @backButton
      @backButton.height = 50
      @backButton.width = 50
    
    @center.height = 50
    @center.left = 125
    @center.right = 125
      
      
    @right.width = 120
    @right.height = 50
   
  ### 
  createIcon: (icon, hasBackButton) =>
    newIcon = Ti.UI.createImageView({
      image: icon
      height: 50
      width: 50
      left: 10
    })
    if hasBackButton
      newIcon.addEventListener("click", options.onBack)
    newIcon
  ###
  ###
  createRightButton: (button) ->
    rightButton = Ti.UI.createView({
      #image: button.image
      right: 10
      height: 50
      width: 50
    })
    rightButton.addEventListener("click", button.onClick)
    rightButton
  ###