root.SearchResultsTableMoreRow_Framework_Android = class SearchResultsTableMoreRow_Framework_Android
  constructor: (options = {}) ->
    @settings = root._.extend {}, options
    
    @moreRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      height: '50dp'
      type: "loadMoreRow"
    })
    
    label = Ti.UI.createLabel {
      text: 'Loading More....'
      color: '#666'
      font: { fontSize: '15dp' }
    }
    
    @moreRow.add label
    
  showLoadMoreButton: =>
    
  hideLoadMoreButton: =>