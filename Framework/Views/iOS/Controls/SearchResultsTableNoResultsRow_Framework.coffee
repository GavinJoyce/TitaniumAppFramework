root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS
  constructor: ->
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#FFF"
      height: "100%"
      touchEnabled: false
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      type: "noResultsRow"
    })
    
    label = Ti.UI.createLabel({
      text: "No Results"
      font: { fontSize: 18 }
      textAlign: "center"
    })
    @noResultsRow.add(label)
    
    button = root.app.create("Button", {
      text: "Reset search parameters"
      fontSize: 15
      height: 36
      width: 250
      bottom: 50
      style: {
        gradient: ["#0082cc", "#0045cc"]
        borderColor: '#0062b8'
        labelShadowColor: "#000"
      }
      onClickStyle: {
        gradient: ['#003cb4', '#0044cc']
      }
      onClick: () =>
    })
    @noResultsRow.add(button.view)