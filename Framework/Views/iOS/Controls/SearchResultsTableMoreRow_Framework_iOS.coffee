root.SearchResultsTableMoreRow_Framework_iOS = class SearchResultsTableMoreRow_Framework_iOS
  constructor: ->
    @moreRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      height: 50
      type: "loadMoreRow"
    })
    
    indicator = Ti.UI.createActivityIndicator({
      top: 15
      message: "Loading More..."
      color: "#333"
      font: { fontSize: 14 }, shadowOffset: { x: 0, y: 1 }, shadowColor: '#fff'
      style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    })
    indicator.show()
    @moreRow.add(indicator)