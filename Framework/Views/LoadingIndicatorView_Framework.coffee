root.LoadingIndicatorView_Framework = class LoadingIndicatorView_Framework extends root.BaseView
  constructor:(options = {}) ->
    super options
    
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @loadingView = Ti.UI.createView({
        top: 0
        height: "100%"
        width: "100%"
      })
      
      @activityIndicator = Ti.UI.createActivityIndicator({
        top: '50%'
        message: "Loading..."
        width: Ti.UI.SIZE
        height: Ti.UI.SIZE
        color: "#333"
        font: { fontSize: 14, fontWeight: 'bold' }, shadowOffset: { x: 0, y: 1 }, shadowColor: '#fff'
        style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
      })

      @loadingView.add(@activityIndicator)
      @activityIndicator.show()
      @add(@loadingView)
    else if Ti.Platform.osname == "android"
      @activityIndicator = Ti.UI.createActivityIndicator({
        width: Ti.UI.SIZE, height: Ti.UI.SIZE
        color: "#333"
        cancelable: true
        style: Ti.UI.ActivityIndicatorStyle.BIG_DARK
        font: { fontSize: '20dp', fontWeight: 'bold' }
      })
      @add(@activityIndicator)
  
  showLoadingIndicator: =>
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @activityIndicator.show()
    else
      @activityIndicator.show()
    
  hideLoadingIndicator: =>
    if Ti.Platform.osname == "iphone" || Ti.Platform.osname == "ipad"
      @activityIndicator.hide()
    else
      @activityIndicator.hide()