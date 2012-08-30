root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    options = root._.extend({
      backgroundColor: 'pink'
    }, options)
    
    @photos = []

    @view = Ti.UI.createView options
    @label = Ti.UI.createLabel { left: 10, top: 10 }
    @view.add @label
    
    @addFromGalleryButton = Ti.UI.createButton { title: 'Add From Gallery', bottom: 50 }
    @addFromGalleryButton.addEventListener 'click', @addFromGallery
    @view.add @addFromGalleryButton
    
    @addFromCameraButton = Ti.UI.createButton { title: 'Add From Camera', bottom: 100 }
    @addFromCameraButton.addEventListener 'click', @addFromCamera
    @view.add @addFromCameraButton
    
    @photo = Ti.UI.createImageView {
      left: 30, top: 100, backgroundColor: 'yellow'
      width: 300
      height: 200
    }
    @view.add @photo
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 250
      height: 500
    }
    @view.add @grid.view
  
    @update()
    
  update: =>
    @label.text = "There are #{@photos.length} photos"
    
    if @photos.length > 0
      @photo.image = @photos[@photos.length-1]
    
  addFromGallery: =>
    
  addFromCamera: =>
    Ti.Media.showCamera { #TODO: GJ: can we set the orientation to force landscape? 
      success: (e) =>
        filename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}.png"
        file = Ti.Filesystem.getFile filename
        if file.exists()
          file.deleteFile()
          file = Ti.Filesystem.getFile filename
        file.write e.media
        @photos.push filename
        @update()
      cancel: ->
      error: ->
    }
