#TODO: GJ: add support for acrolling, reordering and deleting

root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      cellWidth: 140
      cellHeight: 100
      cellMargin: 20
      layout: 'horizontal'
      width: '100%'
    }, options)
    @controls = []
    @view = Ti.UI.createView @settings
  
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
    
  