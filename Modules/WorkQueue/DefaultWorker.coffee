root.WorkQueue.DefaultWorker = class DefaultWorker
  constructor:(@settings) ->    
  execute: (options) => 
    Ti.API.info "Executing WorkQueue.DefaultWorker #{options}"  
    options.onSuccess()

