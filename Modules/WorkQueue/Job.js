(function() {
  var Job,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root.WorkQueue.Job = Job = (function() {

    function Job(options) {
      this.canExecute = __bind(this.canExecute, this);
      this.execute = __bind(this.execute, this);      this.settings = root._.extend({
        worker: 'WorkQueue.DefaultWorker',
        data: {},
        executeOn: new Date()
      }, options);
    }

    Job.prototype.execute = function() {
      var worker;
      worker = root.app.create(this.settings.worker, {
        data: this.settings.data
      });
      return worker.execute();
    };

    Job.prototype.canExecute = function() {
      return this.settings.executeOn <= new Date();
    };

    return Job;

  })();

}).call(this);
