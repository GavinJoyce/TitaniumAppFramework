root.SearchResultsTable_Framework = class SearchResultsTable_Framework
  constructor:(options = {}) ->
    @options = root._.extend {
      top: 0
      onTableClick: (e) =>
      loadMoreOnClick: =>
      resetResultsOnClick: =>
      infiniteScroll: true
      infiniteScrollCallback: (e) => Ti.API.info('SearchResultsTable_Framework.infiniteScrollCallback')
      rowClassName: 'SearchResultsTableRow'
      noResultsRowClassName: 'SearchResultsTableNoResultsRow'
      loadMoreRowClassName: 'SearchResultsTableMoreRow'
      pullToRefresh: false
      pullToRefreshCallback: => Ti.API.info('SearchResultsTable_Framework.pullToRefreshCallback')
      adRowSettings: null
    }, options
    
    @table = @createTableView()
    @moreRow = @createMoreRow()
    @noResultsRow = @createNoResultsRow()

    if @options.infiniteScroll
      @lastDistance = 0
      @addScrollListener()
  
  createTableView: =>
    table = Ti.UI.createTableView {
      top: @options.top
      separatorColor: "#ddd"
    }
    table.addEventListener("click", (e) =>
      switch e.row.type
        when "noResultsRow", "loadMoreRow", "retryRow"
          Ti.API.info("SearchResultsTable_Framework.table: click: do nothing")
        else @options.onTableClick(e)
    )
    table
    
  createMoreRow: =>
    root.app.create(@options.loadMoreRowClassName, {
      loadMoreOnClick: @options.loadMoreOnClick
    })
    
  createNoResultsRow: =>
    root.app.create(@options.noResultsRowClassName, {
      resetResultsOnClick: @options.resetResultsOnClick
    })
     
  addScrollListener: ->
    alert 'SearchResultsTable_Framework.addScrollListener: Abstract override'
    
  update: (items, hasMoreRows, enableAds = false, adData = {}) =>
    Ti.API.info("----- Updating SearchResultsTable -----")
    
    @scrollingEnabled true

    if items.length > 0
      extraRows = []
      for item, index in items
        
        if enableAds && @options.adRowSettings? && root._.contains(@options.adRowSettings.indexes, index)
          adRow = root.app.create(@options.adRowSettings.rowClassName, { height: @options.adRowSettings.height, width: @options.adRowSettings.width, url: @options.adRowSettings.url, adData: adData }).row
          @table.appendRow(adRow)
        
        row = root.app.create(@options.rowClassName, { item: item }).row
        extraRows.push row
      
      if @table.data.length > 0
        @table.deleteRow(@table.data[0].rows.length - 1)
      
      @table.appendRow extraRows
    else
      @scrollingEnabled = false
      @table.setData([@noResultsRow.noResultsRow])

    if hasMoreRows
      @table.hasMoreRows = true
      @table.appendRow(@moreRow.moreRow)
    else
      @table.hasMoreRows = false
    
    Ti.API.info("-- Finished Updating SearchResultsTable --")

  scrollingEnabled: (enabled) =>

  clear: ->
    @table.setData [] 