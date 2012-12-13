root.SearchResultsTableMoreRow_Framework_iOS = class SearchResultsTableMoreRow_Framework_iOS
  constructor: (options = {}) ->
    @settings = root._.extend {}, options
    
    @moreRow = Ti.UI.createTableViewRow {
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      height: 50
      type: "loadMoreRow"
    }
    
    indicator = Ti.UI.createActivityIndicator {
      top: 15
      message: "Loading More..."
      color: root.app.settings.fontThemeColor
      font: { fontSize: 13 }
      style: Ti.UI.iPhone.ActivityIndicatorStyle.DARK
    }
    @moreRow.add(indicator)
    indicator.show()
    
  showLoadMoreButton: =>
    unless @loadMoreWrap
      @loadMoreWrap = Ti.UI.createView({
        height: Ti.UI.FILL
        width: Ti.UI.FILL
        backgroundColor: "#DDD"
      })
      @loadMoreButton = root.app.create("Button", {
        text: "Load More"
        fontSize: 12
        width: 150, height: 30
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
          @hideLoadMoreButton()
      })
      @loadMoreWrap.add(@loadMoreButton.view)
    @moreRow.add(@loadMoreWrap)
    
  hideLoadMoreButton: =>
    @moreRow.remove(@loadMoreWrap) if @loadMoreWrap