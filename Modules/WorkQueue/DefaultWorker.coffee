root.WorkQueue.DefaultWorker = class DefaultWorker
  constructor:(@settings) ->    
  execute: => Ti.API.info "Executing WorkQueue.DefaultWorker"

