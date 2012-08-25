root.TimeoutGroup = class TimeoutGroup
  constructor: ->
    @timeouts = []
    
  delay: (ms, func) -> 
    if ms == 0
      func
    else
      @timeouts.push root.app.delay(ms, func)

  clear: => 
    clearTimeout(timeout) for timeout in @timeouts
    @timeouts = []