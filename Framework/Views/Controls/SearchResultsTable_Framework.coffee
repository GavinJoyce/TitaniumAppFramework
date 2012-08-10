root.SearchResultsTable_Framework = class SearchResultsTable_Framework
  constructor:(options = {}) ->
    @options = root._.extend({
      onTableClick: (e) =>
      infiniteScroll: true
      infiniteScrollCallback: (e) => Ti.API.info("scrolled to bottom")
      rowClassName: "SearchResultsTableRow"
      top: "auto"
    }, options)
    
    @table = Ti.UI.createTableView({
      top: @options.top
    })
    @table.addEventListener("click", @options.onTableClick)
    @moreRow = root.app.create("SearchResultsTableMoreRow").moreRow
    
    if @options.infiniteScroll
      @lastDistance = 0

      @table.addEventListener("scroll", (e) =>
        offset = e.contentOffset.y
        height = e.size.height
        total = offset + height
        theEnd = e.contentSize.height
        distance = theEnd - total
        if distance < @lastDistance
          if (total >= theEnd) && e.contentSize.height > e.size.height && @table.hasMoreRows
            @options.infiniteScrollCallback()
        @lastDistance = distance
      )
    
  clear: ->
    @table.setData([])  
  
  update: (items, hasMoreRows) =>
    Ti.API.info("----- Update Table -----")

    if @table.data != null && @table.data.length > 0 && @table.data[0].rows.length > 0
      rowToDeleteIndex = @table.data[0].rows.length - 1

    @i = 0
    for item in items
      @table.appendRow(root.app.create(@options.rowClassName, { item: item }).row)
      
      if @i == 0 && rowToDeleteIndex
        @table.deleteRow(rowToDeleteIndex)
      
      @i++

    if hasMoreRows
      @table.hasMoreRows = true
      @table.appendRow(@moreRow)
    else
      @table.hasMoreRows = false
    
    Ti.API.info("-- Finish Update Table --")