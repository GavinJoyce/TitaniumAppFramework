(function() {
  var SearchResultsTable_Framework,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  root.SearchResultsTable_Framework = SearchResultsTable_Framework = (function(_super) {

    __extends(SearchResultsTable_Framework, _super);

    function SearchResultsTable_Framework(options) {
      var _this = this;
      if (options == null) options = {};
      this.update = __bind(this.update, this);
      options = root._.extend({
        onTableClick: function(e) {},
        infiniteScroll: true,
        infiniteScrollCallback: function(e) {
          return Ti.API.info("scrolled to bottom");
        },
        rowClassName: "SearchResultsTableRow",
        top: "auto"
      }, options);
      SearchResultsTable_Framework.__super__.constructor.call(this, options);
      this.table = Ti.UI.createTableView({
        top: this.settings.top
      });
      this.moreRow = root.app.create("SearchResultsTableMoreRow").moreRow;
      if (this.settings.infiniteScroll) {
        this.lastDistance = 0;
        this.table.addEventListener("scroll", function(e) {
          var distance, height, offset, theEnd, total;
          offset = e.contentOffset.y;
          height = e.size.height;
          total = offset + height;
          theEnd = e.contentSize.height;
          distance = theEnd - total;
          if (distance < _this.lastDistance) {
            if ((total >= theEnd) && e.contentSize.height > e.size.height && _this.table.hasMoreRows) {
              _this.settings.infiniteScrollCallback();
            }
          }
          return _this.lastDistance = distance;
        });
      }
    }

    SearchResultsTable_Framework.prototype.clear = function() {
      return this.table.setData([]);
    };

    SearchResultsTable_Framework.prototype.update = function(items, hasMoreRows) {
      var item, rowToDeleteIndex, _i, _len;
      Ti.API.info("----- Update Table -----");
      if (this.table.data !== null && this.table.data.length > 0 && this.table.data[0].rows.length > 0) {
        rowToDeleteIndex = this.table.data[0].rows.length - 1;
      }
      for (_i = 0, _len = items.length; _i < _len; _i++) {
        item = items[_i];
        this.table.appendRow(root.app.create(this.settings.rowClassName, {
          item: item
        }).row);
      }
      if (rowToDeleteIndex) this.table.deleteRow(rowToDeleteIndex);
      if (hasMoreRows) {
        this.table.hasMoreRows = true;
        this.table.appendRow(this.moreRow);
      } else {
        this.table.hasMoreRows = false;
      }
      this.table.addEventListener("click", this.settings.onTableClick);
      return Ti.API.info("-- Finish Update Table --");
    };

    return SearchResultsTable_Framework;

  })(root.BaseView);

}).call(this);
