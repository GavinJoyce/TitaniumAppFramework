root.Network = class Network
  constructor: (options) ->
    @settings = root._.extend({
      timeout: 15000
      retryCount: 5
      retryDelay: 500
    }, options)
    
    @xhr = Ti.Network.createHTTPClient({ timeout: @settings.timeout })
    @activeRequest = null
      
  ajax: (options) ->
    options = root._.extend({
      url: null
      params: {}
      xhr: null
      method: 'POST'
      contentType: 'application/x-www-form-urlencoded'
      userID: null
      token: null
      onSuccess: ->
      onError: ->
      onAbort: -> Ti.API.info('root.Network: onAbort')
      onRetry: (retryCount) ->
      try: 0
    }, options)
    
    Ti.API.info('root.network.ajax : ' + options.url)
    
    @reset(options)
    @activeRequest = options
    
    options.xhr = @xhr unless options.xhr
    
    if Ti.Platform.osname != 'iphone' || Ti.Platform.osname != 'ipad'        # CMC put this here as Android was having trouble making multiple requests with params
      options.xhr = Ti.Network.createHTTPClient({ timeout: @settings.timeout })
    
    options.xhr.open('POST', options.url) #TODO: GJ: add support for GET
    options.xhr.setRequestHeader('Content-Type', options.contentType)
    options.xhr.setRequestHeader('MyHome-UserID', options.userID) if options.userID?
    options.xhr.setRequestHeader('MyHome-Token', options.token) if options.token?
    
    options.xhr.onload = (e) ->
      @activeRequest = null
      Ti.API.info "@responseText: #{@responseText}"
      options.onSuccess(JSON.parse(@responseText))
    options.xhr.onerror = () => @onError(options)
    
    if options.contentType == 'application/json'
      options.xhr.send(JSON.stringify(options.params))
    else
      options.xhr.send(options.params)
    
  reset: (options) ->
    if @xhr.readyState not in [0,4]
      Ti.API.info('-------------- Something happening')
      @activeRequest.onAbort() if @activeRequest? && @activeRequest.onAbort?
    
    @xhr.abort()
    @activeRequest = null

  hasActiveRequest: =>
    @activeRequest?

  onError: (options) =>
    @activeRequest = null
    options.try++
    
    if options.try < @settings.retryCount
      Ti.API.info("root.network : retrying ##{options.try}")
      options.onRetry(options.try)
      root.app.delay @settings.retryDelay, => @ajax(options)
    else
      Ti.API.info('network error')
      options.onError(options.xhr.status)
    

    
    