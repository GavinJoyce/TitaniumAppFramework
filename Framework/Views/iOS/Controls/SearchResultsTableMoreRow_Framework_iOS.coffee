root.SearchResultsTableMoreRow_Framework_iOS = class SearchResultsTableMoreRow_Framework_iOS
  constructor: (options = {}) ->
    @settings = root._.extend({}, options)
    
    @moreRow = Ti.UI.createTableViewRow({
      backgroundColor: "#DDD"
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      height: 50
      type: "loadMoreRow"
    })
    
    indicator = Ti.UI.createActivityIndicator({
      top: 15
      message: "Loading More..."
      color: "#333"
      font: { fontSize: 14 }, shadowOffset: { x: 0, y: 1 }, shadowColor: '#fff'
      style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    })
    indicator.show()
    @moreRow.add(indicator)
    
  showLoadMoreButton: =>
    @loadMoreWrap = Ti.UI.createView({
      height: Ti.UI.FILL
      width: Ti.UI.FILL
      backgroundColor: "#DDD"
    })
    @loadMoreButton = root.app.create("Button", {
      text: "Load More"
      fontSize: 12
      height: 30
      width: 150
      style: {
        gradient: ["#0082cc", "#0045cc"]
        borderColor: '#0062b8'
        labelShadowColor: "#000"
      }
      onClickStyle: {
        gradient: ['#003cb4', '#0044cc']
      }
      onClick: =>
        @settings.loadMoreOnClick()
        @moreRow.remove(@loadMoreWrap)
    })
    @loadMoreWrap.add(@loadMoreButton.view)
    @moreRow.add(@loadMoreWrap)