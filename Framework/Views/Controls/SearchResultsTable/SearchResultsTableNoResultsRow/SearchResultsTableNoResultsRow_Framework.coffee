root.SearchResultsTableNoResultsRow_Framework = class SearchResultsTableNoResultsRow_Framework
  constructor: (options = {}) ->
    @options = root._.extend {}, options
    
    @noResultsRow = Ti.UI.createTableViewRow {
      backgroundColor: '#333'
      title: 'No Results'
    }
    @noResultsRow.type = "noResultsRow"