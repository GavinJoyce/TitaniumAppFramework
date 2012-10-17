root.WorkQueue.Job = class Job
  constructor:(options) ->
    @settings = root._.extend({
      worker: 'WorkQueue.DefaultWorker'
      data: {}
      executeOn: new Date()
      onSuccess: ->
      onError: ->
    }, options)

    
  execute: (options) =>
    worker = root.app.create @settings.worker, { data: @settings.data }
    worker.execute {
      onSuccess: =>
        options.onSuccess @
        @settings.onSuccess()
      onError: =>
        options.onError @
        @settings.onError()
      onProgress: (progress) => options.onProgress(@, worker, progress)
    }

  canExecute: =>
    @settings.executeOn <= new Date()