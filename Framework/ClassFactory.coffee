root.ClassFactory = class ClassFactory
  constructor: (options) ->
    @settings = root._.extend({
      cacheEnabled: true
      ignoreAndroidTablet: false
    }, options)
      
    @klassCache = {}  
    @klassNames = @getKlassNames()
    @moduleKlassNames = @getModuleKlassNames()
  
  create: (className, options = {}) ->
    klass = @klassCache[className]
    if klass != undefined
      return new klass(options)
    else
      isModule = className.indexOf('.') > -1
      
      if isModule
        klassNames = @moduleKlassNames
      else
        klassNames = @klassNames
    
      for klassName in klassNames
        klassName = klassName.replace('CLASSNAME', className)
        k = @tryCreate(className, klassName, options)
        return k unless k == null
      alert("could not create type [#{className}]")
        
  tryCreate: (className, klassName, options) ->
    Ti.API.info("Trying to create #{klassName}")
    
    #TODO: GJ: check if all required namespaces exist. try catch for now
    
    try 
      eval("var klass = root.#{klassName}")
      if(typeof klass != 'undefined')
        @klassCache[className] = klass if @settings.cacheEnabled
        Ti.API.info("created #{klassName}")
        return new klass(options)
    catch error
      alert(error)
    return null
    
  getKlassNames: ->
    platformHierarchy = @getPlatformHierarchy()
    klassNames = []
    
    for appLevel in ['App', 'Common']
      for platform in platformHierarchy
        klassNames.push("CLASSNAME_#{appLevel}_#{platform}")
      klassNames.push("CLASSNAME_#{appLevel}")

    for appLevel in ['Framework'] #TODO: GJ: refactor
      for platform in platformHierarchy
        klassNames.push("CLASSNAME_#{appLevel}_#{platform}")
      klassNames.push("CLASSNAME_#{appLevel}")  
      
    klassNames
    
  getModuleKlassNames: ->
    platformHierarchy = @getPlatformHierarchy()
    klassNames = []
    
    for platform in platformHierarchy
      klassNames.push("CLASSNAME_#{platform}")
    klassNames.push("CLASSNAME")
    
    klassNames
    
  getPlatformHierarchy: ->
    if Ti.Platform.osname == 'iphone'
      return ['iPhone', 'iOS']
    else if Ti.Platform.osname == 'ipad'
      return ['iPad', 'iOS']
    else if @isTablet()
      return ['AndroidTablet', 'Android']
    else
      return ['AndroidPhone', 'Android']
      
  isTablet: ->
    return true if Ti.Platform.osname == 'ipad'
    return false if @settings.ignoreAndroidTablet
    dpi = Ti.Platform.displayCaps.dpi
    w = Ti.Platform.displayCaps.platformWidth / dpi
    h = Ti.Platform.displayCaps.platformHeight / dpi
    diagonalSize = Math.sqrt(w*w+h*h)
    return diagonalSize >= 6