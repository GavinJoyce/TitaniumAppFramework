(function() {
  var BaseView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root.BaseView = BaseView = (function() {

    function BaseView(options) {
      var _this = this;
      if (options == null) options = {};
      this.open = __bind(this.open, this);
      this.show = __bind(this.show, this);
      this.focus = __bind(this.focus, this);
      this.uiInitialised = false;
      this.settings = root._.extend({
        title: '',
        backgroundImage: root.app.settings.viewBackgroundImage,
        backgroundRepeat: root.app.settings.viewBackgroundRepeat,
        backgroundColor: root.app.settings.viewBackgroundColor,
        barColor: root.app.settings.viewTitleBarColor,
        fullscreen: false
      }, options);
      this.isPortrait = Ti.UI.orientation === Ti.UI.PORTRAIT || Ti.UI.orientation === Ti.UI.UPSIDE_PORTRAIT;
      this.isLandscape = Ti.UI.orientation === Ti.UI.LANDSCAPE_LEFT || Ti.UI.orientation === Ti.UI.LANDSCAPE_RIGHT;
      this.controls = [];
      this.window = Ti.UI.createWindow(this.settings);
      this.window.title = this.settings.title;
      this.spinner = Ti.UI.createActivityIndicator({
        message: "Loading...",
        width: Ti.UI.SIZE,
        color: "#000",
        font: {
          fontSize: 18
        }
      });
      this.window.add(this.spinner);
      this.window.addEventListener('focus', this.focus);
      this.window.addEventListener('close', this.onClose);
      Ti.App.addEventListener("forceLandscapeWindow", function(e) {
        return _this.window.orientationModes = [Ti.UI.LANDSCAPE_LEFT, Ti.UI.LANDSCAPE_RIGHT];
      });
      Ti.Gesture.addEventListener("orientationchange", function(e) {
        if (Ti.UI.orientation === Ti.UI.PORTRAIT || Ti.UI.orientation === Ti.UI.UPSIDE_PORTRAIT) {
          return _this.onPortrait();
        } else {
          return _this.onLandscape();
        }
      });
    }

    BaseView.prototype.focus = function(e) {
      if (!this.uiInitialised) this.onInit();
      this.onFocus();
      return this.uiInitialised = true;
    };

    BaseView.prototype.onInit = function() {};

    BaseView.prototype.onFocus = function() {};

    BaseView.prototype.showSpinner = function() {
      return this.spinner.show();
    };

    BaseView.prototype.hideSpinner = function() {
      return this.spinner.hide();
    };

    BaseView.prototype.show = function(options) {
      if (options == null) options = {};
      if (root.tabGroup) {
        return root.tabGroup.tabs.activeTab.open(this.window, options);
      } else if (root.navGroup) {
        this.window.inNavGroup = true;
        return root.navGroup.navGroup.open(this.window, options);
      } else {
        return this.open(options);
      }
    };

    BaseView.prototype.open = function(options) {
      if (options == null) options = {};
      options = root._.extend({}, options);
      return this.window.open(options);
    };

    BaseView.prototype.close = function() {
      if (this.window.inNavGroup) {
        return root.navGroup.navGroup.close(this.window);
      } else {
        return this.window.close({
          animated: false
        });
      }
    };

    BaseView.prototype.onClose = function() {};

    BaseView.prototype.add = function(control) {
      this.window.add(control);
      return this.controls.push(control);
    };

    BaseView.prototype.clear = function() {
      var control, _i, _len, _ref;
      _ref = this.controls;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        control = _ref[_i];
        this.window.remove(control);
      }
      return this.controls = [];
    };

    BaseView.prototype.click = function(callback) {
      return this.window.addEventListener("click", callback);
    };

    BaseView.prototype.onPortrait = function() {};

    BaseView.prototype.onLandscape = function() {};

    return BaseView;

  })();

}).call(this);
