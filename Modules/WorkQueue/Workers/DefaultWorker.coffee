root.WorkQueue.DefaultWorker = class DefaultWorker extends root.WorkQueue.Worker
  execute: (options) => 
    Ti.API.info "Executing WorkQueue.DefaultWorker #{options}"  
    options.onSuccess()

