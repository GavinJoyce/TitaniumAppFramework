root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    @settings = root._.extend({
      backgroundColor: '#FFF'
      photos: []
      onUpdate: (photos, thumbnails) ->
    }, options)
    
    @photos = []
    @thumbnails = []

    @view = Ti.UI.createView @settings
    
    @buttons = Ti.UI.createView({
      width: "100%"
      height: Ti.UI.SIZE
      top: 0
      backgroundColor: "#F3F3F3"
    })
    
    @addFromCameraButton = root.app.create("Button", {
      style: {
        gradient: ["#08a700", "#068700"]
        borderColor: "#067d00"
        labelShadowColor: "#067d00"
        labelText: "Take Photo"
        icon: "/Common/Modules/PhotoPicker/Images/camera.png"
        left: 5
        top: 5
        bottom: 5
        height: 30
      }
      onClickStyle: {
       gradient: ["#068700", "#08a700"]
       borderColor: "#067d00"
       labelShadowColor: "#067d00"
      }
      onClick: @addFromCamera
    })
    @buttons.add @addFromCameraButton.button
    
    @addFromGalleryButton = root.app.create("Button", {
      style: {
        gradient: ["#08a700", "#068700"]
        borderColor: "#067d00"
        labelShadowColor: "#067d00"
        labelText: "Choose From Library"
        icon: "/Common/Modules/PhotoPicker/Images/photos.png"
        right: 5
        top: 5
        bottom: 5
        height: 30
      }
      onClickStyle: {
       gradient: ["#068700", "#08a700"]
       borderColor: "#067d00"
       labelShadowColor: "#067d00"
      }
      onClick: @addFromGallery
    })
    @buttons.add @addFromGalleryButton.button
    
    @view.add(@buttons)
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 80
      cellWidth: 100
      cellHeight: 100
      cellMargin: 5
      onRemove: (photo, thumbnail) =>  #TODO: GJ: record existing image deletes
        @photos = @photos.without photo
        @thumbnails = @thumbnails.without thumbnail
        @update()
    }
    @view.add @grid.view
    
    for existingPhoto in @settings.photos
      @grid.addPhoto existingPhoto, existingPhoto #TODO: GJ: thumbnail?
    
    @update()
    
  update: =>
    @settings.onUpdate @photos, @thumbnails
  
  addFromGallery: =>
    Ti.Media.openPhotoGallery {
      mediaTypes:[Ti.Media.MEDIA_TYPE_PHOTO]
      success: (e) => @addMedia e.media
      cancel: ->
      error: ->
    }
    
  addFromCamera: =>
    Ti.Media.showCamera { #TODO: GJ: can we set the orientation to force landscape?
      success: (e) => @addMedia e.media
      cancel: ->
      error: ->
    }
      
  addMedia: (image) =>
    thumbnail = image.imageAsThumbnail(100)
    image = root.PhotoPicker.MediaUtils.scaleImage image, 800 #TODO: GJ: decide on size
    
    filename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}.png"
    thumbfilename = "#{Ti.Filesystem.applicationDataDirectory}photoPicker#{new Date().getTime()}-thumb.png"

    @saveImage image, filename
    @saveImage thumbnail, thumbfilename

    @photos.push filename
    @thumbnails.push thumbfilename
    @grid.addPhoto thumbfilename, filename
    @update()
    
  saveImage: (image, filename) ->
    Ti.API.info "saving image #{filename}"
    file = Ti.Filesystem.getFile filename
    if file.exists()
      file.deleteFile()
      file = Ti.Filesystem.getFile filename
    file.write image
