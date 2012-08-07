root.NoInternetView_Framework = class NoInternetView_Framework
  constructor:(options = {}) ->
    options = root._.extend({}, options)
    
    @window = Ti.UI.createWindow({
      modal: true
      backgroundColor: "#FFF"
      title: "Connection Issue"
    })