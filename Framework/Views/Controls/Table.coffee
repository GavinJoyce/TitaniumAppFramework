root.Table_Framework = class Table_Framework
  constructor:(options = {}) ->
    options = root._.extend({}, options)
    
    @table = Ti.UI.createTableView(options)
    
    
  setData: (data) =>
    rows = []
    for rowData in data
      row = Ti.UI.createTableViewRow({
        title: rowData.title
        hasDetail: rowData.hasDetail
        hasChild: rowData.hasChild
        backgroundColor: "#FFF"
        color: "#333"
        height: 44
      })
      row.name = rowData.name
      row.target = target
      
      if rowData.value
        value = Ti.UI.createLabel({
          text: rowData.value
          textAlign: "right"
          right: 10
        })
        row.value = value
        row.add(value)
        
      for param in rowData.extraParams
        row[param] = param
        
      rows.push(row)
      
    @table.appendRows(rows)
        
    