(function() {
  var Job;

  root.WorkQueue.Job = Job = (function() {

    function Job(name, data, executeOn) {
      if (name == null) name = 'WorkQueue.DefaultWorker';
      if (data == null) data = {};
      if (executeOn == null) executeOn = new Date();
    }

    return Job;

  })();

}).call(this);
