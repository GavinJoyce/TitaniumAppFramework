root.Network = class Network
  constructor: (options) ->
    @settings = root._.extend({
      timeout: 15000
      retryCount: 30
      retryDelay: 500
    }, options)
    
    @xhr = Ti.Network.createHTTPClient({ timeout: @settings.timeout })
      
  ajax: (options) ->
    options = root._.extend({
      url: null
      params: {}
      method: 'POST'
      onSuccess: ->
      onError: ->
      onRetry: (retryCount) ->
      try: 0
    }, options)
    
    Ti.API.info('root.network.ajax : ' + options.url)
    
    @reset()
    @xhr.open('POST', options.url) #TODO: GJ: add support for GET
    @xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    @xhr.onload = () -> options.onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () => @onError(options)
    @xhr.send(options.params)
    
  reset: -> @xhr.abort()
    
  onError: (options) ->
    options.try++
    
    if options.try < @settings.retryCount
      Ti.API.info("root.network : retrying ##{options.try}")
      options.onRetry(options.try)
      root.app.delay(options.retryDelay, (options) => @ajax(options))
    else
      options.onError
    

    
    