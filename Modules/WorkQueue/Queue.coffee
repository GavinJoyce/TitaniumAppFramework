#TODO: GJ: persist jobs to db?

root.WorkQueue.Queue = class Queue
  constructor:(options = {}) -> 
    @settings = root._.extend({
      checkFrequency: 5000
    }, options)
    @running = false
    
    @jobs = []
    
  add: (job) =>
    Ti.API.info "[WorkQueue.Queue] Adding job"
    @jobs.push job
    
  check: => #execute a job if one is available
    Ti.App.fireEvent 'HeadsUp.HeadsUpMessage.close', {}
    availableJobs = @jobs.filter (job) -> job.canExecute()
    Ti.API.info "[WorkQueue.Queue]#{@jobs.length} jobs, #{availableJobs.length} available jobs"
    
    if availableJobs.length > 0
      job = availableJobs[0]
      Ti.App.fireEvent 'HeadsUp.HeadsUpMessage.update', {
        message: 'Job Starting'
        progress: 0
      }
      job.execute {
        onSuccess: @onJobSuccess
        onError: @onJobError
        onProgress: @onJobProgress
      }
      
    else
      @scheduleCheck()
    
  onJobSuccess: (job) =>
    Ti.API.info 'job was successful ' + job.settings.worker
    @jobs = @jobs.without job
    @check()
    
  onJobError: (job) =>
    Ti.API.info 'job was error'
    @jobs = @jobs.without job #TODO: GJ: retry or set error state?
    @check()
    
  onJobProgress: (job, worker, progress) => #progress between 0 and 1
    Ti.API.info "Job progress #{progress}"
    
    if worker.settings.showProgress
      Ti.App.fireEvent 'HeadsUp.HeadsUpMessage.update', {
        message: 'Job in Progress'
        progress: progress
      }
    
  scheduleCheck: -> setTimeout(@check, @settings.checkFrequency) if @running
  
  start: =>
    unless @running
      @running = true
      @check()
    
  stop: =>
    @running = false