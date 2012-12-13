root.SearchResultsTableNoResultsRow_Framework_Android = class SearchResultsTableNoResultsRow_Framework_Android extends root.SearchResultsTableNoResultsRow_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    
    @noResultsRow = Ti.UI.createTableViewRow {
      height: '200dp'
    }
    @noResultsRow.type = "noResultsRow"

    label = Ti.UI.createLabel {
      top: '20dp'
      text: 'No Results'
      font: { fontSize: '16dp', fontWeight: 'bold' }
      color: '#000'
    }

    button = Ti.UI.createButton {
      title: 'Reset Search'
      width: '150dp', height: '50dp'
    }
    button.addEventListener('click', options.resetResultsOnClick)

    @noResultsRow.add label
    @noResultsRow.add button