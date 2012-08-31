root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    options = root._.extend({
      backgroundColor: '#eee'
    }, options)
    
    @photos = []
    @thumbnails = []

    @view = Ti.UI.createView options
    @label = Ti.UI.createLabel { left: 10, top: 2 }
    @view.add @label
    
    @addFromGalleryButton = Ti.UI.createButton { title: '+ Gallery', top: 34, left: 2 }
    @addFromGalleryButton.addEventListener 'click', @addFromGallery
    @view.add @addFromGalleryButton
    
    @addFromCameraButton = Ti.UI.createButton { title: '+ Camera', top: 34, right: 2 }
    @addFromCameraButton.addEventListener 'click', @addFromCamera
    @view.add @addFromCameraButton
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 80
      cellWidth: 100
      cellHeight: 100
      cellMargin: 5
    }
    @view.add @grid.view
  
    @update()
    
  update: =>
    @label.text = "There are #{@photos.length} photos"
    
  addMedia: (image) =>
    thumbnail = image.imageAsThumbnail(100)
    
    filename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}.png"
    thumbfilename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}-thumb.png"
    
    @saveImage image, filename
    @saveImage thumbnail, thumbfilename
    
    @photos.push filename
    @thumbnails.push thumbfilename
    @grid.addPhoto thumbfilename
    @update()
  
  addFromGallery: =>
    Ti.Media.openPhotoGallery {
      mediaTypes:[Ti.Media.MEDIA_TYPE_PHOTO]
      success: (e) =>
        @addMedia e.media
      cancel: ->
      error: ->
    }
    
  addFromCamera: =>
    Ti.Media.showCamera { #TODO: GJ: can we set the orientation to force landscape?
      success: (e) =>
        @addMedia e.media
      cancel: ->
      error: ->
    }
    
  saveImage: (image, filename) ->
    Ti.API.info "saving image #{filename}"
    file = Ti.Filesystem.getFile filename
    if file.exists()
      file.deleteFile()
      file = Ti.Filesystem.getFile filename
    file.write image
