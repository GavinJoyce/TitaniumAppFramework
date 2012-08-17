root.WorkQueue.Queue = class Queue
  constructor:(options = {}) -> 
    options = root._.extend({

    }, options)
    
    @items = []
    
  enqueue: (job) =>
    @items.push job
  
  #TODO: GJ: build a queue