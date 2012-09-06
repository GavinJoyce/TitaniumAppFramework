root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS
  constructor: ->
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      backgroundSelectedColor: "#DDD"
      height: "100%"
      touchEnabled: false
      type: "noResultsRow"
    })
    
    label = Ti.UI.createLabel({
      text: "No Results"
      font: { fontSize: 20, fontWeight: "bold" }
      textAlign: "center"
    })
    @noResultsRow.add(label)