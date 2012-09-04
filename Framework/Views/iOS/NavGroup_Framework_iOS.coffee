root.NavGroup_Framework_iOS = class NavGroup_Framework_iOS
  constructor:(options = {}) ->
    options = root._.extend({}, options)

    @window = Ti.UI.createWindow({ navBarHidden: true })    
    @navGroup = Ti.UI.iPhone.createNavigationGroup(options)
    @window.add(@navGroup)
    
    @window.open()

  close: =>
    @window.close()
    
  open: (window) =>
    @navGroup.open(window)
