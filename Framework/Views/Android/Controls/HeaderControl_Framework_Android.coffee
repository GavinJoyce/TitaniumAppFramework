root.HeaderControl_Framework_Android = class HeaderControl_Framework_Android
  constructor: (options = {}) ->
    @options = root._.extend({}, options)

    @view = Ti.UI.createView {
      top: 0
      width: "100%", height: 70
      backgroundColor: @options.backgroundColor
    }
    
    @centerView = Ti.UI.createView {
      top: 0, bottom: 0
      width: Ti.UI.SIZE, height: 70
      layout: "horizontal"
    }
    
    @leftView = Ti.UI.createView {
      left: 0, top: 0, bottom: 0
      width: Ti.UI.SIZE, height: 70
      layout: "horizontal"
    }

    @rightView = Ti.UI.createView {
      right: 0, top: 0, bottom: 0
      width: Ti.UI.SIZE, height: 70
      layout: "horizontal"
    }

    @view.add @centerView
    @view.add @leftView
    @view.add @rightView

  setLeftNavButton: =>
    alert 'HeaderControl_Framework_Android: setLeftNavButton'
    
  setRightNavButton: =>
    alert 'HeaderControl_Framework_Android: setRightNavButton'