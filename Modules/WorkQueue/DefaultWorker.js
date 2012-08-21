(function() {
  var DefaultWorker,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root.WorkQueue.DefaultWorker = DefaultWorker = (function() {

    function DefaultWorker(settings) {
      this.settings = settings;
      this.execute = __bind(this.execute, this);
    }

    DefaultWorker.prototype.execute = function() {
      return Ti.API.info("Executing WorkQueue.DefaultWorker");
    };

    return DefaultWorker;

  })();

}).call(this);
