root.SoundCache = class SoundCache
  constructor: (options) ->
    @settings = root._.extend({}, options)
    @sounds = {}
  
  play: (url) ->
    Ti.API.info "playing #{url}"
    sound = @register url, false
    sound.stop()
    sound.play()
    
  register: (url, preload = true) ->
    sound = @sounds[url]
    
    unless sound
      sound = Ti.Media.createSound({ url: url })
      @sounds[url] = sound
      
      if preload
        sound.volume = 0
        sound.play
        sound.volume = 1
    sound