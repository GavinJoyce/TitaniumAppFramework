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
    @view = Ti.UI.createView({
      height: @settings.height
      width: @settings.width
      top: @settings.top
    })
    
    @placeHolder = Ti.UI.createView({
      height: @settings.height
      width: @settings.width
      backgroundColor: "#EFEFEF"
      zIndex: 1
    })
    @placeHolder.add(Ti.UI.createLabel({
      text: "No Photos", shadowOffset: { x: 0, y: 1 }, shadowColor: '#fff'
      font: { fontSize: 16 }
      color: "#333"
    }))
    @view.add(@placeHolder)
    
    @scrollView = Ti.UI.createScrollView @settings
    @scrollView.top = 0
    @scrollView.zIndex = 2
    @view.add(@scrollView)
  
  addPhoto: (thumb, filename) ->
    photo = root.app.create 'PhotoPicker.Photo', {
      image: thumb
      thumb: thumb
      filename: filename
      onRemoveClick: (photo) =>
        @controls = @controls.without(photo.view)
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