root.SearchResultsTableNoResultsRow_Framework_iOS = class SearchResultsTableNoResultsRow_Framework_iOS extends root.SearchResultsTableNoResultsRow_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    
    @noResultsRow = Ti.UI.createTableViewRow({
      backgroundColor: "#FFF"
      selectionStyle: Ti.UI.iPhone.TableViewCellSelectionStyle.NONE
      height: "100%"
      type: "noResultsRow"
    })

    label = Ti.UI.createLabel({
      text: "No Results"
      font: { fontSize: 18 }
      textAlign: "center"
    })
    @noResultsRow.add(label)
    
    button = root.app.create("Button", {
      text: "Reset Search"
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
      onClick: options.resetResultsOnClick
    })
    @noResultsRow.add(button.view)