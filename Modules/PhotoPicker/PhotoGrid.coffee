#TODO: GJ: add support for acrolling, reordering and deleting

root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      cellWidth: 140
      cellHeight: 100
      cellMargin: 20
      layout: 'horizontal'
      width: '100%'
      height: Ti.UI.FILL
      contentWidth: 320
    }, options)
    @controls = []
    @view = Ti.UI.createScrollView({
      contentWidth: @settings.contentWidth
      contentHeight: "auto"
      showVerticalScrollIndicator: true
      showHorizontalScrollIndicator: false
      layout: @settings.layout
      top: @settings.top
      width: @settings.width
      height: @settings.height
    })
  
  addPhoto: (url) ->
    cell = Ti.UI.createImageView {
      width: @settings.cellWidth
      height: @settings.cellHeight
      left: @settings.cellMargin
      top: @settings.cellMargin / 2
      image: url
    }
    
    @controls.push cell
    @view.add cell
    
  clear: () ->
    @view.remove control for control in @controls
    @controls = []
  
  addPhotos: (photos) =>
    @addPhoto photo for photo in photos
    
  