(function() {
  var SearchResultsTableMoreRow_Framework_iOS;

  root.SearchResultsTableMoreRow_Framework_iOS = SearchResultsTableMoreRow_Framework_iOS = (function() {

    function SearchResultsTableMoreRow_Framework_iOS() {
      var indicator;
      this.moreRow = Ti.UI.createTableViewRow({
        backgroundColor: "#DDD",
        height: 50
      });
      indicator = Ti.UI.createActivityIndicator({
        message: "Loading More...",
        color: "#333",
        font: {
          fontSize: 14
        },
        style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
      });
      indicator.show();
      this.moreRow.add(indicator);
    }

    return SearchResultsTableMoreRow_Framework_iOS;

  })();

}).call(this);
