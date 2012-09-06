root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS
  constructor: ->
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      height: "100%"
    })
    
    label = Ti.UI.createLabel({
      text: "No Results"
      font: { fontSize: 20, fontWeight: "bold" }
      textAlign: "center"
    })
    @noResultsRow.add(label)