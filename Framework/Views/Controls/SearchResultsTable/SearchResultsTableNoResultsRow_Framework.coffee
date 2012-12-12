root.SearchResultsTableNoResultsRow_Framework = class SearchResultsTableNoResultsRow_Framework
  constructor: (options = {}) ->
    @options = root._.extend {}, options
    
    @noResultsRow = Ti.UI.createTableViewRow {
      backgroundColor: '#FFF'
      height: '100%'
      title: 'No Results'
    }
    @noResultsRow.type = "noResultsRow"