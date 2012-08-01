root.SearchResultsTable_Framework = class SearchResultsTable_Framework extends root.BaseView
  constructor:(options = {}) ->
    options = root._.extend({
      onTableClick: (e) =>
      infiniteScroll: true
      infiniteScrollCallback: (e) => Ti.API.info("scrolled to bottom")
      rowClassName: "SearchResultsTableRow"
      top: "auto"
    }, options)
    super(options)
    
    @table = Ti.UI.createTableView({
      top: @settings.top
    })
    @moreRow = root.app.create("SearchResultsTableMoreRow").moreRow
    
    if @settings.infiniteScroll
      @lastDistance = 0

      @table.addEventListener("scroll", (e) =>
        offset = e.contentOffset.y
        height = e.size.height
        total = offset + height
        theEnd = e.contentSize.height
        distance = theEnd - total
        if distance < @lastDistance
          if (total >= theEnd) && e.contentSize.height > e.size.height && @table.hasMoreRows
            @settings.infiniteScrollCallback()
        @lastDistance = distance
      )
    
  clear: ->
    @table.setData([])  
  
  update: (items, hasMoreRows) =>
    Ti.API.info("----- Update Table -----")

    if @table.data != null && @table.data.length > 0 && @table.data[0].rows.length > 0
      rowToDeleteIndex = @table.data[0].rows.length - 1

    for item in items
      @table.appendRow(root.app.create(@settings.rowClassName, { item: item }).row)
      
    if rowToDeleteIndex
      @table.deleteRow(rowToDeleteIndex)

    if hasMoreRows
      @table.hasMoreRows = true
      @table.appendRow(@moreRow)
    else
      @table.hasMoreRows = false

    @table.addEventListener("click", @settings.onTableClick)
    
    Ti.API.info("-- Finish Update Table --")