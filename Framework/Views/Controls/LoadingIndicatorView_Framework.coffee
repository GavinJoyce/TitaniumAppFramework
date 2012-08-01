root.LoadingIndicatorView_Framework = class LoadingIndicatorView_Framework extends root.BaseView
  constructor:(options = {}) ->
    options = root._.extend({
      title: 'LoadingIndicatorView_Framework_Common'
    }, options)
    super(options)
    
    @loadingView = Ti.UI.createView({
      background: "red"
      height: "100%"
      width: "100%"
    })
    activityIndicator = Ti.UI.createActivityIndicator({
      message: "Loading..."
      width: "auto"
      height: "auto"
      color: "#333"
      font: { fontSize: 16 }
    })
    
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      activityIndicator.style = Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    
    @loadingView.add(activityIndicator)
    activityIndicator.show()
    @window.add(@loadingView)