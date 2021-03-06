root.framework.include('/Common/Framework/Network.js')
root.framework.include('/Common/Framework/SoundCache.js')
root.framework.include('/Common/Framework/TimeoutGroup.js')

root.moduleNames = []

root.MobileAppBase = class MobileAppBase
  constructor: (options) ->
    @settings = root._.extend({
      title: 'MobileAppBase'
      viewBackgroundImage: null
      viewBackgroundRepeat: true
      viewBackgroundColor: null
      viewBackgroundGradient: null
      viewTitleBarColor: '#000000'
      viewTitleBarGradient: null
      viewTitleBarImage: null
      debugMode: false
      noInternetViewEnabled: false
      ignoreAndroidTablet: false
      useImageButtons: false
    }, options)
    
    @debugMode = @settings.debugMode
    
    if @settings.googleAnalyticsID
      @analytics = new Analytics(@settings.googleAnalyticsID, @settings.appName, @settings.appVersion)
      @analytics.start(10)
    
    @sounds = new root.SoundCache()
    @classFactory = new root.ClassFactory({ ignoreAndroidTablet: @settings.ignoreAndroidTablet })
    @network = new root.Network()
    @includedFiles = []
    @zIndex = 100
    
    Ti.Network.addEventListener('change', (e) => @checkInternet(e.online) if !@checking)
  
  
    
  delay: (ms, func) -> 
    if ms == 0
      func()
    else
      setTimeout(func, ms)
      
  randomDelay: (randomDelay, minDelay, func) -> @delay (Math.random() * randomDelay) + minDelay, func
  timeout: (ms, func) -> setInterval func, ms #TODO: GJ: rename to interval

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
    
  checkInternet: (isOnline) =>
    @checking = true
    
    isOnline = Ti.Network.online unless isOnline?

    if isOnline
      Ti.API.info('Welcome to the internet')
      @noInternetView.window.close() if @noInternetView
    else
      Ti.API.info('Bloody hell, the network just DISSAPEARED!')
      @noInternetView = @create("NoInternetView") unless @noInternetView
      if @settings.noInternetViewEnabled
        @noInternetView.window.open()

    @checking = false
    
  createRadialGradient: (colour1, colour2) ->
    if Ti.Platform.osname == "android"
      { 
        type: 'linear'
        startPoint: { x: "50%", y: "50%" }
        endPoint: { x: "50%", y: "50%" }
        colors: [ colour1, colour2 ]
        startRadius: '90%'
        endRadius: 0
        backfillStart: true 
      }
    else
      { 
        type: 'radial',
        startPoint: { x: "50%", y: "50%" }
        endPoint: { x: "50%", y: "50%" }
        colors: [ colour1, colour2 ]
        startRadius: '90%'
        endRadius: 0
        backfillStart: true 
      }
      
  trackPageview: (pageUrl) => @analytics.trackPageview(pageUrl) if @analytics