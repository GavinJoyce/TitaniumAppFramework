root.SearchResultsTableMoreRow_Framework_Android = class SearchResultsTableMoreRow_Framework_Android
  constructor: ->
    @moreRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      height: 50
    })
    
    text = Ti.UI.createLabel({
      text: "Loading More..."
      color: "#333"
      font: { fontSize: 14 }
    })
    @moreRow.add(text)