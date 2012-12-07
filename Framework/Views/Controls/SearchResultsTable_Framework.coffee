root.SearchResultsTable_Framework = class SearchResultsTable_Framework
  constructor:(options = {}) ->
    @options = root._.extend {
      top: 0
      onTableClick: (e) =>
      loadMoreOnClick: =>
      resetResultsOnClick: =>
      infiniteScroll: true
      infiniteScrollCallback: (e) => Ti.API.info("scrolled to bottom")
      rowClassName: "SearchResultsTableRow"
      noResultsRowClassName: "SearchResultsTableNoResultsRow"
      loadMoreRowClassName: "SearchResultsTableMoreRow"
      pullToRefresh: false
      pullToRefreshCallback: (e) => Ti.API.info("pull to refresh fired")
      adRowSettings: null
    }, options
    
    @table = Ti.UI.createTableView {
      top: @options.top
      separatorColor: "#ddd"
    }
    @table.addEventListener("click", (e) =>
      switch e.row.type
        when "noResultsRow", "loadMoreRow", "retryRow"
          Ti.API.info("do nothing")
        else @options.onTableClick(e)
    )
    
    @moreRow = @createMoreRow()
    @noResultsRow = @createNoResultsRow()

    if @options.infiniteScroll
      @lastDistance = 0
      @addScrollListener()
  
  createMoreRow: =>
    root.app.create(@options.loadMoreRowClassName, {
      loadMoreOnClick: @options.loadMoreOnClick
    })
    
  createNoResultsRow: =>
    root.app.create(@options.noResultsRowClassName, {
      resetResultsOnClick: @options.resetResultsOnClick
    })
     
  addScrollListener: ->
    
  update: (items, hasMoreRows, enableAds = false) =>
    Ti.API.info("----- Update Table -----")
    
    @table.scrollable = true

    if @table.data != null && @table.data.length > 0 && @table.data[0].rows.length > 0
      rowToDeleteIndex = @table.data[0].rows.length - 1

    if items.length > 0
      @i = 0
      for item in items
        
        if enableAds && @options.adRowSettings? && root._.contains(@options.adRowSettings.indexes, @i)
          adRow = root.app.create(@options.adRowSettings.rowClassName, { height: @options.adRowSettings.height, width: @options.adRowSettings.width, url: @options.adRowSettings.url }).row
          @table.appendRow(adRow)
        
        @table.appendRow(root.app.create(@options.rowClassName, { item: item }).row)
      
        if @i == 0 && rowToDeleteIndex
          @table.deleteRow(rowToDeleteIndex)
      
        @i++
    else
      @table.scrollable = false
      @table.setData([@noResultsRow.noResultsRow])

    if hasMoreRows
      @table.hasMoreRows = true
      @table.appendRow(@moreRow.moreRow)
    else
      @table.hasMoreRows = false
    
    Ti.API.info("-- Finish Update Table --")

  clear: ->
    @table.setData [] 