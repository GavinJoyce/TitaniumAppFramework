Ti.include('ClassFactory.js')
Ti.include('Lib/analytics.js')

root._ = require('Common/Framework/Lib/underscore')._
_ = root._

root.moduleNames = []

root.Framework = class Framework
  constructor: (options) ->
    @settings = root._.extend({}, options)
    @classFactory = new root.ClassFactory()
    @includedFiles = []
        
  includePath: (path = "", recursive = false) =>
    for file in @getFiles(path, recursive)
      Ti.API.info("Including #{file}")
      @include file

  includeModule: (moduleName) ->
    root.moduleNames.push moduleName
    root[moduleName] = {}
    @includePath("Common/Modules/#{moduleName}", true)
    
  include: (file) =>    
    if @includedFiles.indexOf(file) == -1
      filePath = Titanium.Filesystem.resourcesDirectory + file
      Ti.API.info("Including ..... #{file}")
      Ti.include(filePath)
      @includedFiles.push file
    else
      Ti.API.info("Skipping ..... #{file}")

  getFiles: (path = "", recursive = false) ->
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
          additional = @getFiles("#{path}/#{item}", recursive)
          files = files.concat additional
    root._.uniq files
    
  isTablet: ->
    return true if Ti.Platform.osname == 'ipad'
    dpi = Ti.Platform.displayCaps.dpi
    w = Ti.Platform.displayCaps.platformWidth / dpi
    h = Ti.Platform.displayCaps.platformHeight / dpi
    diagonalSize = Math.sqrt(w*w+h*h)
    return diagonalSize >= 6
    
  post: (url, params, onSuccess, onError = null) =>
    @xhr.abort()
    @xhr.open('POST', url)
    @xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    @xhr.onload = () ->
      onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () ->
      onError() if onError
    @xhr.send(params)