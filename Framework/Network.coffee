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
    
    # Ti.API.info("#{@xhr.readyState}: READY STATE CHANGED")
    # @xhr.setOnreadystatechange((e) => Ti.API.info("#{e.source.readyState}: READY STATE CHANGED"))
    
    @xhr.open('POST', options.url) #TODO: GJ: add support for GET
    @xhr.setRequestHeader('Content-Type', options.contentType)
    @xhr.setRequestHeader('MyHome-UserID', options.userID) if options.userID?
    @xhr.setRequestHeader('MyHome-Token', options.token) if options.token?
    
    @xhr.onload = (e) ->
      @activeRequest = null;
      Ti.API.info "@responseText: #{@responseText}"
      options.onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () => @onError(options)
    
    if options.contentType == 'application/json'
      @xhr.send(JSON.stringify(options.params))
    else
      @xhr.send(options.params)
    
  reset: (options) ->
    if @xhr.readyState not in [0,4]
      Ti.API.info('-------------- Something happening')
      @activeRequest.onAbort() if @activeRequest.onAbort?
    
    @xhr.abort()
    @activeRequest = null;
    
  onError: (options) =>
    @activeRequest = null;
    options.try++
    
    if options.try < @settings.retryCount
      Ti.API.info("root.network : retrying ##{options.try}")
      options.onRetry(options.try)
      root.app.delay @settings.retryDelay, => @ajax(options)
    else
      Ti.API.info('network error')
      options.onError(@xhr.status)
    

    
    