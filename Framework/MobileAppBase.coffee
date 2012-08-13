root.framework.include('/Common/Framework/Network.js')

root.moduleNames = []

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
      noInternetViewEnabled: false
    }, options)
    
    if @settings.googleAnalyticsID
      @analytics = new Analytics(@settings.googleAnalyticsID, @settings.appName, @settings.appVersion)
      @analytics.start(10)
      
    @classFactory = new root.ClassFactory()
    @network = new root.Network()
    @includedFiles = []
    @zIndex = 100
    
    Ti.Network.addEventListener('change', (e) => @checkInternet() if !@checking)
    
  delay: (ms, func) -> setTimeout func, ms
  randomDelay: (randomDelay, minDelay, func) -> @delay (Math.random() * randomDelay) + minDelay, func
  timeout: (ms, func) -> setInterval func, ms

  debug: (msg) -> Ti.API.info(msg)

  create: (className, options = {}) -> @classFactory.create(className, options)

  post: (url, params, onSuccess, onError = null) => #TODO: GJ: depreciate
    @network.ajax({
      url: url
      params: params
      onSuccess: onSuccess
      onError: onError
    })

  noInternetEnable: =>
    @settings.noInternetViewEnabled = true
    @checkInternet() if !@checking
    
  noInternetDisable: =>
    @settings.noInternetViewEnabled = false
    @checkInternet() if !@checking
    
  checkInternet: =>
    @checking = true

    if Ti.Network.online
      Ti.API.info('Welcome to the internet')
      @noInternetView = @create("NoInternetView") unless @noInternetView
      @noInternetView.window.close()
    else
      Ti.API.info('Bloody hell, the network just DISSAPEARED!')
      if @noInternetView? && @settings.noInternetViewEnabled
        @noInternetView.window.open()

    @checking = false