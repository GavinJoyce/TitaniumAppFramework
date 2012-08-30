root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      backgroundColor: 'lightblue'
      cellWidth: 140
      cellHeight: 100
      cellMargin: 10
    }, options)
    
    @view = Ti.UI.createView options
    
    
  setData: (cells = null) ->
    root.app.delay 20, => #TEMP: GJ: so that there is a size
    
      unless cells
        cells = []
        for i in [0..99] #some dummy cells for now
          cellView = Ti.UI.createView({
            backgroundColor: 'red'
            width: @settings.cellWidth
            height: @settings.cellHeight
            left: @settings.cellMargin
          })
          cellLabel = Ti.UI.createLabel({
            color:"white"
            font:{fontSize:48,fontWeight:'bold'}
            text:i.toString()
            touchEnabled:false
          })
          cellView.add cellLabel
          cells.push cellView
    
      width = @view.getSize().width #TODO: GJ: default width if null
      width = 500 unless width
      Ti.API.info "the width is #{width}"
    
    
      #TODO: GJ: clear
    
      data = []
    
      cellsPerRow = Math.floor(width / (@settings.cellWidth + @settings.cellMargin))
      Ti.API.info "there are #{cellsPerRow} cellsPerRow"
      rowCount = Math.floor(cells.length / cellsPerRow) - 1
      Ti.API.info "there are #{rowCount} rows"
    
      cellIndex = 0
      for rowIndex in [0..rowCount]
        Ti.API.info "adding row #{rowIndex} (#{cellIndex})"
        row = Ti.UI.createTableViewRow({
          className: "grid"
          layout: "horizontal"
          height: @settings.cellHeight + @settings.cellMargin
          backgroundColor: 'yellow'
          selectedBackgroundColor:"green"
        })
      
        for i in [0..cellsPerRow-1]
          if cells[cellIndex]
            cells[cellIndex].cellIndex = cellIndex
            row.add cells[cellIndex]
            cellIndex++
    
        data.push row
   
      tableview = Ti.UI.createTableView({
        data:data
      })
    
      tableview.addEventListener "click", (e) ->
        if e.source.cellIndex
          alert('clicked cell ' + e.source.cellIndex)


      @view.add tableview
      
    
   