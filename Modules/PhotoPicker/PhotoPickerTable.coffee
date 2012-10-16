root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    @settings = root._.extend({
      backgroundColor: '#EEE'
      photos: []
      onUpdate: (photos, thumbnails) ->
    }, options)
    
    @photos = @settings.photos
    @thumbnails = []

    @view = Ti.UI.createView @settings
    
    @buttons = Ti.UI.createView({
      width: "100%"
      height: Ti.UI.SIZE
      top: 0
      backgroundColor: "#3b3b43"
    })
    
    @addFromCameraButton = root.app.create("Button", {
      text: "Take Photo"
      left: 10
      top: 10
      bottom: 10
      height: 34
      width: 120
      iconSettings: {
        image: "/Common/Modules/PhotoPicker/Images/black/camera.png"
        height: 20
        width: 20
        left: 5
        right: 5
      }
      style: {
        gradient: ["#EEE", "#CECECE"]
        borderColor: "#222"
        labelShadowColor: "#FFF"
        labelColor: "#222"
      }
      onClickStyle: {
       gradient: ["#CECECE", "#EEE"]
      }
      onClick: @addFromCamera
    })
    @buttons.add @addFromCameraButton.view
    
    @addFromGalleryButton = root.app.create("Button", {
      text: "From Library"
      right: 10
      top: 10
      bottom: 10
      height: 34
      width: 120
      iconSettings: {
        image: "/Common/Modules/PhotoPicker/Images/black/photos.png"
        height: 20
        width: 20
        left: 5
        right: 5
      }
      style: {
        gradient: ["#EEE", "#CECECE"]
        borderColor: "#222"
        labelShadowColor: "#FFF"
        labelColor: "#222"
      }
      onClickStyle: {
       gradient: ["#CECECE", "#EEE"]
      }
      onClick: @addFromGallery
    })
    @buttons.add @addFromGalleryButton.view
    
    @view.add(@buttons)
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 60
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
      popoverView: @addFromGalleryButton.view
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
