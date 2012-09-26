root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS
  constructor: ->
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#FFF"
      height: "100%"
      touchEnabled: false
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      type: "noResultsRow"
    })