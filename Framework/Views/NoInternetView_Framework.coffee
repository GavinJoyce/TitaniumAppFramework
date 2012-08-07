root.NoInternetView_Framework = class NoInternetView_Framework
  constructor:(options = {}) ->
    options = root._.extend({}, options)
    
    @window = Ti.UI.createWindow({
      modal: true
      backgroundColor: "#FFF"
      title: "Connection Issue"
      barColor: "red"
    })
    
    message = Ti.UI.createLabel({
      text: "Please enable your internet connection"
      color: "#333"
      textAlign: "center"
      font: { fontSize: 18, fontWeight: "bold" }
    })
    @window.add(message)