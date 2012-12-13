root.framework.include("/Common/Framework/Views/Controls/SearchResultsTable/SearchResultsTable_Framework.js")
root.SearchResultsTable_Framework_Android = class SearchResultsTable_Framework_Android extends root.SearchResultsTable_Framework
  constructor:(options = {}) ->
    options = root._.extend {}, options
    super options
    
  addScrollListener: ->
    @table.addEventListener("scroll", (e) =>
      if e.totalItemCount > e.visibleItemCount && e.firstVisibleItem + e.visibleItemCount == e.totalItemCount && @table.hasMoreRows
        @options.infiniteScrollCallback()
    )