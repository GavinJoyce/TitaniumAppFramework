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
      onJobProgress: (progress) => options.onJobProgress @, progress
    }

  canExecute: =>
    @settings.executeOn <= new Date()
  