(function() {
  var Queue,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root.WorkQueue.Queue = Queue = (function() {

    function Queue(options) {
      if (options == null) options = {};
      this.enqueue = __bind(this.enqueue, this);
      options = root._.extend({}, options);
      this.items = [];
    }

    Queue.prototype.enqueue = function(job) {
      return this.items.push(job);
    };

    return Queue;

  })();

}).call(this);
