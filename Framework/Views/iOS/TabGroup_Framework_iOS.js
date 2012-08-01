(function() {
  var TabGroup_Framework_iOS;

  root.TabGroup_Framework_iOS = TabGroup_Framework_iOS = (function() {

    function TabGroup_Framework_iOS(options) {
      var tab, view, _i, _len, _ref;
      if (options == null) options = {};
      options = root._.extend({
        views: [
          {
            View: "",
            Callback: null,
            Tab: {
              Name: "Tab 1",
              Icon: ""
            }
          }
        ]
      }, options);
      this.tabs = Ti.UI.createTabGroup();
      _ref = options.views;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        tab = Ti.UI.createTab({
          title: view.Tab.Name,
          icon: view.Tab.Icon,
          window: view.View.window
        });
        this.tabs.addTab(tab);
        if (view.Callback != null) tab.addEventListener("click", view.Callback);
      }
    }

    TabGroup_Framework_iOS.prototype.setActiveTab = function(index) {
      return this.tabs.setActiveTab(index);
    };

    return TabGroup_Framework_iOS;

  })();

}).call(this);
