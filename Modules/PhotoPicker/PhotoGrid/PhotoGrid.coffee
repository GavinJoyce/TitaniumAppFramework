root.PhotoPicker.PhotoGrid = class PhotoGrid
  constructor:(options = {}) ->
    @settings = root._.extend({
      layout: 'horizontal'
      width: '100%'
      height: Ti.UI.FILL
      onRemove: (thumb, filename) ->
    }, options)
    @controls = []
    
    @view = @createView()
    @placeHolder = @createPlaceHolder()
    @scrollView = @createScrollView()

    @view.add @placeHolder
    @view.add @scrollView
  
  createView: ->
    Ti.UI.createView {
      height: @settings.height
      width: @settings.width
      top: @settings.top
    }
    
  createPlaceHolder: ->
    placeHolder = Ti.UI.createView {
      height: @settings.height
      width: @settings.width
      visible: false
    }
    
    placeHolder.add @createPlaceHolderLabel()
    placeHolder
    
  createPlaceHolderLabel: ->
    Ti.UI.createLabel {
      text: "No Photos"
      font: { fontSize: 16 }
      color: "#111"
    }
    
  createScrollView: ->
    Ti.UI.createScrollView {
      top: 0
      layout: 'horizontal'
      contentWidth: 320
      contentHeight: "auto"
      showVerticalScrollIndicator: true
      showHorizontalScrollIndicator: false
    }
  
  addPhoto: (thumb, filename) ->
    photo = root.app.create 'PhotoPicker.Photo', {
      image: thumb
      thumb: thumb
      filename: filename
      onRemoveClick: (photo) =>
        @controls = root._.without(@controls, photo.view)
        @scrollView.remove photo.view
        @settings.onRemove(photo.settings.thumb, photo.settings.filename)
    }
    
    @controls.push photo.view
    @scrollView.add photo.view
    @checkForPhotos()
    
  clear: () ->
    @scrollView.remove control for control in @controls
    @controls = []
    @settings.onUpdate()
  
  addPhotos: (photos) =>
    @addPhoto photo for photo in photos
    
  checkForPhotos: =>
    if @controls.length > 0
      @placeHolder.hide()
    else
      @placeHolder.show()