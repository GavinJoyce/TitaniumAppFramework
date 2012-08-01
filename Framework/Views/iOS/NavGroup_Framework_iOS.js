(function() {
  var NavGroup_Framework_iOS;

  root.NavGroup_Framework_iOS = NavGroup_Framework_iOS = (function() {

    function NavGroup_Framework_iOS(options) {
      if (options == null) options = {};
      options = root._.extend({}, options);
      this.window = Ti.UI.createWindow({
        navBarHidden: true
      });
      this.navGroup = Ti.UI.iPhone.createNavigationGroup(options);
      this.window.add(this.navGroup);
      this.window.open();
    }

    return NavGroup_Framework_iOS;

  })();

}).call(this);
