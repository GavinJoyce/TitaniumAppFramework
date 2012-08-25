root.LoadingIndicatorView_Framework = class LoadingIndicatorView_Framework extends root.BaseView
  constructor:(options = {}) ->
    options = root._.extend({
      title: 'LoadingIndicatorView_Framework_Common'
    }, options)
    super(options)
    
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @loadingView = Ti.UI.createView({
        height: "100%"
        width: "100%"
      })
      @activityIndicator = Ti.UI.createActivityIndicator({
        message: "Loading..."
        width: Ti.UI.SIZE
        height: Ti.UI.SIZE
        color: "#333"
        font: { fontSize: 16 }
        style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
      })

      @loadingView.add(@activityIndicator)
      @activityIndicator.show()
      @add(@loadingView)
  
  showLoadingIndicator: =>
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @activityIndicator.show()
    
  hideLoadingIndicator: =>
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @activityIndicator.hide()