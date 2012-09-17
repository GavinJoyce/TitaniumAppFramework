root.SearchResultsTable_Framework_iOS = class SearchResultsTable_Framework_iOS extends root.SearchResultsTable_Framework
  constructor:(options = {}) ->
    @options = root._.extend({}, options)
    super
    
    @pulling = false
    @reloading = false
    @offset = 0
    
    tableHeader = Ti.UI.createView({
      backgroundColor:'#e2e7ed'
      width: Ti.UI.FILL
      height: 60
    })

    border = Ti.UI.createView({
      backgroundColor:'#576c89'
      bottom:0
      height:2
    })
    tableHeader.add(border)
    
    @table.headerPullView = tableHeader

    @table.addEventListener('scroll', (e) =>
      @offset = e.contentOffset.y
      if @pulling && !@reloading && @offset > -80 && @offset < 0
        @pulling = false
      else if !@pulling && !@reloading && @offset < -80
        @pulling = true
    )
    
    @table.addEventListener('dragEnd', (e) =>
      if @pulling && !@reloading && @offset < -80
        @pulling = false
        @reloading = true
        e.source.setContentInsets({ top: 80 }, { animated: true })
        @options.pullToRefreshCallback(e)
        @resetPullHeader()
    )
    
  resetPullHeader: ->
    @reloading = false
    @table.setContentInsets({ top: 0 }, { animated: true })
  
  getFormattedDate: ->
    date = new Date()
    return date.getMonth() + '/' + date.getDate() + '/' + date.getFullYear() + ' ' + date.getHours() + ':' + date.getMinutes()