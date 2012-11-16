root.SearchResultsTable_Framework_iOS = class SearchResultsTable_Framework_iOS extends root.SearchResultsTable_Framework
  constructor:(options = {}) ->
    @options = root._.extend({}, options)
    super
    
    if @options.pullToRefresh
      @pulling = false
      @reloading = false
      @offset = 0
    
      tableHeader = @createTableHeader()
    
      @table.headerPullView = tableHeader

      @table.addEventListener('scroll', (e) =>
        @offset = e.contentOffset.y
      
        if @pulling && !@reloading && @offset < -50
          @pulling = false
          @headerLabel.text = "Release to refresh..."
        else if !@pulling && !@reloading && @offset > -50
          @pulling = true
          @headerLabel.text = "Pull down to refresh..."
      )

      @table.addEventListener('dragEnd', (e) =>
        if !@reloading && @offset < -50
          @pulling = false
          @reloading = true
          @table.setContentInsets({ top: 50 }, { animated: true })
          @options.pullToRefreshCallback(e)
      )
    
  resetPullHeader: ->
    @reloading = false
    @table.setContentInsets({ top: 0 }, { animated: true })
    @headerLabel.text = "Pull down to refresh..."
  
  getFormattedDate: ->
    date = new Date()
    return date.getMonth() + '/' + date.getDate() + '/' + date.getFullYear() + ' ' + date.getHours() + ':' + date.getMinutes()
  
  addScrollListener: ->
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
    
  createTableHeader: =>
    tableHeader = Ti.UI.createView({
      backgroundColor: "#e2e7ed"
      width: Ti.UI.FILL
      height: 50
    })

    border = Ti.UI.createView({
      backgroundColor: '#576c89'
      bottom: 0
      height: 1
    })
    tableHeader.add(border)
    
    headerContents = Ti.UI.createView({
      layout: "horizontal"
      height: Ti.UI.SIZE
      width: Ti.UI.SIZE
      bottom: 10
    })
    
    activityIndicator = Ti.UI.createActivityIndicator({
      height: 30
      width: Ti.UI.SIZE
      left: 0
      right: 15
      style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    })
    activityIndicator.show()
    headerContents.add(activityIndicator)
    
    @headerLabel = Ti.UI.createLabel({
      color: "#576c89"
      font: { fontSize: 13 }
      text: "Pull down to refresh..."
      textAlign: "center"
      width: Ti.UI.SIZE
      height: Ti.UI.SIZE
    })
    headerContents.add(@headerLabel)
    
    tableHeader.add(headerContents)
    tableHeader