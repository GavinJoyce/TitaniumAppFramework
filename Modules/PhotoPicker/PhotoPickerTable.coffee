root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    options = root._.extend({
      backgroundColor: 'pink'
    }, options)
    
    @photos = []

    @view = Ti.UI.createView options
    @label = Ti.UI.createLabel { left: 10, top: 10 }
    @view.add @label
    
    @addFromGalleryButton = Ti.UI.createButton { title: '+ Gallery', top: 50, left: 2 }
    @addFromGalleryButton.addEventListener 'click', @addFromGallery
    @view.add @addFromGalleryButton
    
    @addFromCameraButton = Ti.UI.createButton { title: '+ Camera', top: 50, right: 2 }
    @addFromCameraButton.addEventListener 'click', @addFromCamera
    @view.add @addFromCameraButton
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 100
      bottom: 0
      cellWidth: 100
      cellHeight: 100
      cellMargin: 5
    }
    @view.add @grid.view
  
    @update()
    
  update: =>
    @label.text = "There are #{@photos.length} photos"
    
    if @photos.length > 0
      @grid.setPhotos(@photos)
    else
      @grid.setData()
    
  addFromGallery: =>
    alert 'TODO'
    
  addFromCamera: =>
    Ti.Media.showCamera { #TODO: GJ: can we set the orientation to force landscape?  #TODO: GJ: resize image for thumbnail?
      success: (e) =>
        image = e.media
        thumbnail = image.imageAsThumbnail(100)
        
        filename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}.png"
        file = Ti.Filesystem.getFile filename
        if file.exists()
          file.deleteFile()
          file = Ti.Filesystem.getFile filename
        file.write thumbnail
        @photos.push filename
        @update()
      cancel: ->
      error: ->
    }
