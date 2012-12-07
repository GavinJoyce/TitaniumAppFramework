root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    @settings = root._.extend({
      backgroundColor: '#EEE'
      photos: []
      onUpdate: (photos, thumbnails) ->
    }, options)
    
    @photos = @settings.photos
    @thumbnails = []

    @view = @createToolbar()
    @grid = @createPhotoGrid()
    @view.add @grid.view
    
    for existingPhoto in @settings.photos
      @grid.addPhoto existingPhoto, existingPhoto #TODO: GJ: thumbnail?
    
    @update()
    
  createToolbar: =>
    view = Ti.UI.createView @settings
    
    buttonView = Ti.UI.createView {
      top: 0
      width: "100%", height: 54
      backgroundColor: "#3b3b43"
    }
    
    if Ti.Media.isCameraSupported
      buttonView.add @createCameraButton().view
    
    @addFromGalleryButton = @createGalleryButton()
    buttonView.add @addFromGalleryButton.view
    
    view.add buttonView
    view
    
  createCameraButton: =>
    root.app.create("Button", {
      text: "Take Photo"
      left: 10, top: 10, bottom: 10
      width: 120, height: 34
      iconSettings: {
        left: 5, right: 5
        image: "/Common/Modules/PhotoPicker/Images/black/camera.png"
        width: 20, height: 20
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
    
  createGalleryButton: =>
    root.app.create("Button", {
      text: "From Library"
      top: 10, right: 10, bottom: 10
      width: 120, height: 34
      iconSettings: {
        image: "/Common/Modules/PhotoPicker/Images/black/photos.png"
        width: 20, height: 20
        left: 5, right: 5
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
    
  createPhotoGrid: ->
    root.app.create 'PhotoPicker.PhotoGrid', {
      top: 54
      onRemove: (photo, thumbnail) =>  #TODO: GJ: record existing image deletes
        @photos = @photos.without photo
        @thumbnails = @thumbnails.without thumbnail
        @update()
    }
    
  update: =>
    @settings.onUpdate @photos, @thumbnails
    @grid.checkForPhotos()
  
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
