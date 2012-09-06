root.WorkQueue.Job = class Job
  constructor:(options) ->
    @settings = root._.extend({
      worker: 'WorkQueue.DefaultWorker'
      data: {}
      executeOn: new Date()
    }, options)

    
  execute: (options) =>
    worker = root.app.create @settings.worker, { data: @settings.data }
    worker.execute {
      onSuccess: => options.onSuccess @
      onError: => options.onError @
      onJobProgress: (percent) => options.onJobProgress @, percent
    }

  canExecute: =>
    @settings.executeOn <= new Date()
  