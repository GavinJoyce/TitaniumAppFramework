Ti.include('ClassFactory.js')
Ti.include('Lib/analytics.js')

root._ = require('Common/Framework/Lib/underscore')._
_ = root._

root.moduleNames = []

root.MobileAppBase = class MobileAppBase
  constructor: (options) ->
    @settings = root._.extend({
      title: 'MobileAppBase'
      viewBackgroundImage: ""
      viewBackgroundRepeat: true
      viewBackgroundColor: '#FFFFFF'
      viewTitleBarColor: '#000000'
      debugMode: false
    }, options)
    
    if @settings.googleAnalyticsID
      @analytics = new Analytics(@settings.googleAnalyticsID, @settings.appName, @settings.appVersion)
      @analytics.start(10)
      
    @classFactory = new root.ClassFactory()
    @xhr = Ti.Network.createHTTPClient({ timeout: 15000 })
    
  delay: (ms, func) -> setTimeout func, ms
  
  create: (className, options = {}) ->
    @classFactory.create(className, options)
        
  @include: (path = "", recursive = false) =>
    for file in root.MobileAppBase.getFiles(path, recursive)
      Ti.API.info("Including #{file}")
      Ti.include(Titanium.Filesystem.resourcesDirectory + file)

  @includeModule: (moduleName) ->
    root.moduleNames.push moduleName
    root[moduleName] = {}
    @include("Common/Modules/#{moduleName}", true);

  @getFiles: (path = "", recursive = false) ->
    dir = Titanium.Filesystem.getFile(Titanium.Filesystem.resourcesDirectory + "/" + path)
    items = dir.getDirectoryListing()
    files = []

    if items?
      for item in items
        if item.indexOf('.js') != -1
          files.push "#{path}/#{item}"
        else if item.indexOf('.coffee') != -1
          files.push "#{path}/#{item.replace('.coffee', '.js')}"
        else if item.indexOf('.dummy') != -1
          files.push "#{path}/#{item.replace('.dummy', '.js')}"

      for item in items
        if recursive and item.indexOf('.') == -1 and item.indexOf('_') != 0 #TODO:GJ: a better way of checking for dir
          additional = root.MobileAppBase.getFiles("#{path}/#{item}", recursive)
          files = files.concat additional
    root._.uniq files
    
  post: (url, params, onSuccess, onError = null) =>
    @xhr.abort()
    @xhr.open('POST', url)
    @xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    @xhr.onload = () ->
      onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () ->
      onError() if onError
    @xhr.send(params)