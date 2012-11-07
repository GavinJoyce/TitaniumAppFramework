root.SlideMenu.Wrapper = class Wrapper
  constructor: (options = {}) ->
    @settings = root._.extend({
      mainWindow: Ti.UI.createWindow({ backgroundColor: "#FFF" })
      leftMenu: Ti.UI.createWindow({ backgroundColor: "green", width: 150, top: 0, left: 0, zIndex: 1 })
      rightMenu: Ti.UI.createWindow({ backgroundColor: "blue", width: 150, top: 0, right: 0, zIndex: 1 })
      baseWindow: null
    }, options)

    @settings.mainWindow.zIndex = 10

    @mainView = Ti.UI.createWindow()
    @nav = Ti.UI.iPhone.createNavigationGroup({
      window: @settings.mainWindow
      width: Ti.Platform.displayCaps.platformWidth
      left: 0
    })
    @mainView.add(@nav)
    
    @openLeftAnimation = Ti.UI.createAnimation({
      left: 150
      curve: Ti.UI.ANIMATION_CURVE_EASE_OUT
      duration: 200
    })
    
    @openRightAnimation = Ti.UI.createAnimation({
      left: -150
      curve: Ti.UI.ANIMATION_CURVE_EASE_OUT
      duration: 200
    })
    
    @closeAnimation = Ti.UI.createAnimation({
      left: 0
      curve: Ti.UI.ANIMATION_CURVE_EASE_OUT
      duration: 200
    })
    

  toggleLeft: =>
    if @settings.leftMenu.isOpen
      @mainView.animate(@closeAnimation)
      @settings.leftMenu.isOpen = false
    else
      @mainView.animate(@openLeftAnimation)
      @settings.leftMenu.isOpen = true
    
  toggleRight: =>
    if @settings.rightMenu.isOpen
      @mainView.animate(@closeAnimation)
      @settings.rightMenu.isOpen = false
    else
      @mainView.animate(@openRightAnimation)
      @settings.rightMenu.isOpen = true
      
      
  init: () =>
    @settings.leftMenu.open()
    @settings.rightMenu.open()
    @mainView.open()
    
    touchStartX = 0
    touchStarted = false
    
    @settings.mainWindow.addEventListener("swipe", (e) =>
      if e.direction == "left"
        unless @settings.rightMenu.isOpen || @settings.leftMenu.isOpen
          @toggleRight()
      else if e.direction == "right"
        unless @settings.leftMenu.isOpen || @settings.rightMenu.isOpen
          @toggleLeft()
    )