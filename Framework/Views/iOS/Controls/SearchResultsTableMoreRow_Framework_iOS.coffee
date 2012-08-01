root.SearchResultsTableMoreRow_Framework_iOS = class SearchResultsTableMoreRow_Framework_iOS
  constructor: ->
    @moreRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      height: 50
    })
    
    indicator = Ti.UI.createActivityIndicator({
      message: "Loading More..."
      color: "#333"
      font: { fontSize: 14 }
      style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    })
    indicator.show()
    @moreRow.add(indicator)