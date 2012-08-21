(function() {
  var Queue,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root.WorkQueue.Queue = Queue = (function() {

    function Queue(options) {
      if (options == null) options = {};
      this.stop = __bind(this.stop, this);
      this.start = __bind(this.start, this);
      this.check = __bind(this.check, this);
      this.add = __bind(this.add, this);
      this.settings = root._.extend({
        checkFrequency: 5000
      }, options);
      this.running = false;
      this.jobs = [];
    }

    Queue.prototype.add = function(job) {
      return this.jobs.push(job);
    };

    Queue.prototype.check = function() {
      var completedJobs, job, _i, _len, _ref;
      Ti.API.info("[WorkQueue.Queue] There are " + this.jobs.length + " items in the queue");
      completedJobs = [];
      _ref = this.jobs;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        job = _ref[_i];
        if (!(job.canExecute())) continue;
        job.execute();
        this.jobs = this.jobs.without(job);
      }
      if (this.running) {
        return setTimeout(this.check, this.settings.checkFrequency);
      }
    };

    Queue.prototype.start = function() {
      if (!this.running) {
        this.running = true;
        return this.check();
      }
    };

    Queue.prototype.stop = function() {
      return this.running = false;
    };

    return Queue;

  })();

}).call(this);
