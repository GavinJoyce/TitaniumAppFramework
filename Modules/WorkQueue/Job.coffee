root.WorkQueue.Job = class Job
  constructor:(options) ->
    @settings = root._.extend({
      worker: 'WorkQueue.DefaultWorker'
      data: {}
      executeOn: new Date()
    }, options)

    
  execute: =>
    worker = root.app.create @settings.worker, { data: @settings.data }
    worker.execute()

  canExecute: =>
    @settings.executeOn <= new Date()
  