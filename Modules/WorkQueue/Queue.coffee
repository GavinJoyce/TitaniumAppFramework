#TODO: GJ: should we persist jobs to db?

root.WorkQueue.Queue = class Queue
  constructor:(options = {}) -> 
    @settings = root._.extend({
      checkFrequency: 5000
    }, options)
    @running = false
    
    @jobs = []
    
  add: (job) =>
    @jobs.push job
    
  check: =>
    Ti.API.info "[WorkQueue.Queue] There are #{@jobs.length} items in the queue"
    
    completedJobs = []
    for job in @jobs when job.canExecute()
      job.execute()
      @jobs = @jobs.without job
    
    setTimeout(@check, @settings.checkFrequency) if @running
    
  start: =>
    unless @running
      @running = true
      @check()
    
  stop: =>
    @running = false