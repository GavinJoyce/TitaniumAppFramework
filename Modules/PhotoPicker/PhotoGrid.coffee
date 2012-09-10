root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      layout: 'horizontal'
      width: '100%'
      height: Ti.UI.FILL
      contentWidth: 320
      contentHeight: "auto"
      showVerticalScrollIndicator: true
      showHorizontalScrollIndicator: false
      onRemove: (thumb, filename) ->
    }, options)
    @controls = []
    @view = Ti.UI.createScrollView @settings
  
  addPhoto: (thumb, filename) ->
    photo = root.app.create 'PhotoPicker.Photo', {
      image: thumb
      thumb: thumb
      filename: filename
      onRemoveClick: (photo) =>
        @controls = @controls.without(photo.view)
        @view.remove photo.view
        @settings.onRemove(photo.settings.thumb, photo.settings.filename)
    }
    
    @controls.push photo.view
    @view.add photo.view
    
  clear: () ->
    @view.remove control for control in @controls
    @controls = []
    @settings.onUpdate()
  
  addPhotos: (photos) =>
    @addPhoto photo for photo in photos