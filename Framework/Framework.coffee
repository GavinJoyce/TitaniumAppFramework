Ti.include('ClassFactory.js')
Ti.include('Lib/analytics.js')

root._ = require('Common/Framework/Lib/underscore')._
_ = root._

Array::first = -> _.first @ #TODO: GJ: move to extensions.js
Array::without = (value) -> _.without @, value
Array::shuffle = -> _.shuffle(@) 
Array::random = -> @.shuffle().first()

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
    
  fromJson: (json, klass) ->
    obj = new klass()
    for key, value of JSON.parse(json)
      obj[key] = value
    obj
    
  deepExtend = (object, extenders...) ->
    return {} if not object?
    for other in extenders
      for own key, val of other
        if not object[key]? or typeof val isnt "object"
          object[key] = val
        else
          object[key] = deepExtend object[key], val
    object
    
  post: (url, params, onSuccess, onError = null) =>
    @xhr.abort()
    @xhr.open('POST', url)
    @xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    @xhr.onload = () ->
      onSuccess(JSON.parse(@responseText))
    @xhr.onerror = () ->
      onError() if onError
    @xhr.send(params)