root.PhotoPicker.PhotoPickerTable = class PhotoPickerTable
  constructor:(options = {}) ->
    @settings = root._.extend({
      backgroundColor: '#eee'
    }, options)
    
    @photos = []
    @thumbnails = []

    @view = Ti.UI.createView @settings
    @label = Ti.UI.createLabel { left: 10, top: 2 }
    @view.add @label
    
    @addFromGalleryButton = Ti.UI.createButton { title: '+ Gallery', top: 34, left: 2 }
    @addFromGalleryButton.addEventListener 'click', @addFromGallery
    @view.add @addFromGalleryButton
    
    @addCatButton = Ti.UI.createButton { title: '+ Cat', top: 34, left: 140 }
    @addCatButton.addEventListener 'click', @addCat
    @view.add @addCatButton
    
    @addFromCameraButton = Ti.UI.createButton { title: '+ Camera', top: 34, right: 2 }
    @addFromCameraButton.addEventListener 'click', @addFromCamera
    @view.add @addFromCameraButton
    
    @grid = root.app.create 'PhotoPicker.PhotoGrid', {
      top: 80
      cellWidth: 100
      cellHeight: 100
      cellMargin: 5
      onRemove: (photo, thumbnail) => 
        @photos = @photos.without photo
        @thumbnails = @thumbnails.without thumbnail
        @update() #TODO: GJ: should we delete files?
    }
    @view.add @grid.view
    @update()
    
  update: =>
    @label.text = "There are #{@photos.length} photos"
  
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
    
  addCat: => #TEMP: GJ: adding remote images so that we can test on simulator
    url = "http://placekitten.com/g/#{[100,110,120,130].random()}/#{[100,110,120,130].random()}"
  
    @photos.push url
    @thumbnails.push url
    @grid.addPhoto url, url
    @update()
    
  addMedia: (image) =>
    thumbnail = image.imageAsThumbnail(100)
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
