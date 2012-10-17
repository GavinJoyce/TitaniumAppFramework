#TODO: GJ: persist jobs to db?

root.WorkQueue.Queue = class Queue
  constructor:(options = {}) -> 
    @settings = root._.extend({
      checkFrequency: 5000
    }, options)
    @running = false
    @checking = false
    @activeJob = null
    
    @jobs = []
    
  add: (job) =>
    Ti.API.info "[WorkQueue.Queue] Adding job"
    @jobs.push job
    
  check: (recurring = false) => #execute a job if one is available
    Ti.API.info 'checking...'
    unless @checking
      @checking = true
      Ti.App.fireEvent 'HeadsUp.HeadsUpMessage.close', {}
      availableJobs = @jobs.filter (job) -> job.canExecute()
      Ti.API.info "[WorkQueue.Queue]#{@jobs.length} jobs, #{availableJobs.length} available jobs"
  
      if availableJobs.length > 0
        @activeJob = availableJobs[0]
      
        @activeJob.execute {
          onSuccess: @onJobSuccess
          onError: @onJobError
          onProgress: @onJobProgress
        }
      else
        @checking = false
        @scheduleCheck() if recurring
      
  onJobSuccess: (job) =>
    Ti.API.info 'job was successful ' + job.settings.worker
    @jobs = @jobs.without job
    @checking = false
    @activeJob = null
    @check true
    
  onJobError: (job) =>
    Ti.API.info 'job was error'
    @jobs = @jobs.without job #TODO: GJ: retry or set error state?
    @checking = false
    @activeJob = null
    @check true
    
  onJobProgress: (job, worker, progress) => #progress between 0 and 1
    Ti.API.info "Job progress #{progress}"
    
    if worker.settings.showProgress
      Ti.App.fireEvent 'HeadsUp.HeadsUpMessage.update', {
        message: 'Job in Progress'
        progress: progress
      }
    
  scheduleCheck: -> 
    if @scheduledCheck then clearTimeout @scheduledCheck
    @scheduledCheck = setTimeout((=> @check(true)), @settings.checkFrequency) if @running
  
  start: =>
    Ti.API.info 'starting job queue'
    unless @running
      @running = true
      @check(true)
    
  stop: =>
    @running = false