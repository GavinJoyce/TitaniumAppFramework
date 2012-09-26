root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS
  constructor: (options = {}) ->
    @options = root._.extend({}, options)
    
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#FFF"
      height: "100%"
      touchEnabled: false
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      type: "noResultsRow"
    })