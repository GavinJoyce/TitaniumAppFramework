root.WorkQueue.Worker = class Worker
  constructor:(options) ->
    @settings = root._.extend({
      showProgress: false
    }, options)
    
  execute: (options) => alert('worker.execute is not yet implemented')

