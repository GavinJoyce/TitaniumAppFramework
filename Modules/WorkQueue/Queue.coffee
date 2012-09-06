#TODO: GJ: should we persist jobs to db?

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
    Ti.API.info "[WorkQueue.Queue] There are #{@jobs.length} items in the queue"
    availableJobs = @jobs.filter (job) -> job.canExecute()
    Ti.API.info "[WorkQueue.Queue] There are #{availableJobs.length} available jobs in the queue"
    
    if availableJobs.length > 0
      job = availableJobs[0]
      job.execute {
        onSuccess: @onJobSuccess
        onError: @onJobError
        onJobProgress: @onJobProgress
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
    
  onJobProgress: (job, percent) =>
    Ti.API.info "Job progress #{percent}"
    
  scheduleCheck: -> setTimeout(@check, @settings.checkFrequency) if @running
  
  start: =>
    unless @running
      @running = true
      @check()
    
  stop: =>
    @running = false