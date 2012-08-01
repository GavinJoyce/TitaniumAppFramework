(function() {
  var LoadingIndicatorView_Framework,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root.LoadingIndicatorView_Framework = LoadingIndicatorView_Framework = (function(_super) {

    __extends(LoadingIndicatorView_Framework, _super);

    function LoadingIndicatorView_Framework(options) {
      var activityIndicator;
      if (options == null) options = {};
      options = root._.extend({
        title: 'LoadingIndicatorView_Framework_Common'
      }, options);
      LoadingIndicatorView_Framework.__super__.constructor.call(this, options);
      this.loadingView = Ti.UI.createView({
        background: "red",
        height: "100%",
        width: "100%"
      });
      activityIndicator = Ti.UI.createActivityIndicator({
        message: "Loading...",
        width: "auto",
        height: "auto",
        color: "#333",
        font: {
          fontSize: 16
        }
      });
      if (Ti.Platform.osname === "iphone" || Ti.Platform.osname === "ipad") {
        activityIndicator.style = Ti.UI.iPhone.ActivityIndicatorStyle.DARK;
      }
      this.loadingView.add(activityIndicator);
      activityIndicator.show();
      this.window.add(this.loadingView);
    }

    return LoadingIndicatorView_Framework;

  })(root.BaseView);

}).call(this);
