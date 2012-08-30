root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      cellWidth: 140
      cellHeight: 100
      cellMargin: 20
    }, options)
    
    @view = Ti.UI.createView options
    
    @tableView = Ti.UI.createTableView { data:[] }
  
    @tableView.addEventListener "click", (e) ->
      if e.source.cellIndex
        alert('clicked cell ' + e.source.cellIndex)

    @view.add @tableView
    
  setPhotos: (photos) ->
    cells = []
    for photo in photos
      cells.push Ti.UI.createImageView {
        width: @settings.cellWidth
        height: @settings.cellHeight
        left: @settings.cellMargin
        top: @settings.cellMargin / 2
        image: photo
      }
    @setData cells
    
  setData: (cells = null) ->
    root.app.delay 20, => #TEMP: GJ: so that there is a size
      unless cells
        cells = []
        for i in [0..30] #some dummy cells for now
          cellView = Ti.UI.createView({
            width: @settings.cellWidth
            height: @settings.cellHeight
            left: @settings.cellMargin
          })
          cellLabel = Ti.UI.createLabel({
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
      rowCount = Math.floor(cells.length / cellsPerRow)
      Ti.API.info "there are #{rowCount} rows"
    
      cellIndex = 0
      for rowIndex in [0..rowCount]
        Ti.API.info "adding row #{rowIndex} (#{cellIndex})"
        row = Ti.UI.createTableViewRow({
          className: "grid"
          layout: "horizontal"
          height: @settings.cellHeight + @settings.cellMargin
        })
      
        for i in [0..cellsPerRow-1]
          if cells[cellIndex]
            cells[cellIndex].cellIndex = cellIndex
            row.add cells[cellIndex]
            cellIndex++
    
        data.push row
      @tableView.setData data
   
     
      
    
   