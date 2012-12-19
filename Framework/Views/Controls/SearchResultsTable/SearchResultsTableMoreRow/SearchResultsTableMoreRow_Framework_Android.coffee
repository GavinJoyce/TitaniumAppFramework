root.SearchResultsTableMoreRow_Framework_Android = class SearchResultsTableMoreRow_Framework_Android
  constructor: ->
    @moreRow = Ti.UI.createTableViewRow {
      height: '50dp'
    }
    text = Ti.UI.createLabel {
      text: "Loading More..."
      color: root.app.settings.fontThemeColor
      font: { fontSize: '13dp', fontWeight: 'bold' }
    }
    @moreRow.add text
    
  showLoadMoreButton: =>
    
  hideLoadMoreButton: =>