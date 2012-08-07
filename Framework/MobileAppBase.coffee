root.MobileAppBase = class MobileAppBase
  constructor: (options) ->
    @settings = root._.extend({
      title: 'MobileAppBase'
      viewBackgroundImage: ""
      viewBackgroundRepeat: true
      viewBackgroundColor: null
      viewBackgroundGradient: null
      viewTitleBarColor: '#000000'
      debugMode: false
      internetRequired: true
    }, options)
    
    if @settings.googleAnalyticsID
      @analytics = new Analytics(@settings.googleAnalyticsID, @settings.appName, @settings.appVersion)
      @analytics.start(10)
      
    @classFactory = new root.ClassFactory()
    @xhr = Ti.Network.createHTTPClient({ timeout: 15000 })
    @includedFiles = []
    
    if @settings.internetRequired
      @noInternetView = @create("NoInternetView")
      @checkInternet()
      Ti.Network.addEventListener('change', (e) => @checkInternet())
    
  delay: (ms, func) -> setTimeout func, ms
  create: (className, options = {}) -> @classFactory.create(className, options)

  post: (url, params, onSuccess, onError = null) =>
    @xhr.abort()
    @xhr.open('POST', url)
    @xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    @xhr.onload = () ->
      onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () ->
      onError() if onError
    @xhr.send(params)
    
    
  checkInternet: ->
    if(Ti.Network.online)
      Ti.API.info('Welcome to the internet')
      @noInternetView.window.close()
    else
      Ti.API.info('Bloody hell, the network just DISSAPEARED!')
      @noInternetView.window.open()