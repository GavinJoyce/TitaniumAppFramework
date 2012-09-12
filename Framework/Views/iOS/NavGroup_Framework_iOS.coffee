root.NavGroup_Framework_iOS = class NavGroup_Framework_iOS
  constructor:(options = {}) ->
    options = root._.extend({
      modal: false
    }, options)

    @window = Ti.UI.createWindow({ navBarHidden: true })    
    @navGroup = Ti.UI.iPhone.createNavigationGroup(options)
    @window.add(@navGroup)
    
    @window.open({ modal: options.modal })

  close: =>
    @window.close()
    
  open: (window) =>
    @navGroup.open(window)
