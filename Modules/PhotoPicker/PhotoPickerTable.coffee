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
  
    @update()
    
  update: =>
    @label.text = "There are #{@photos.length} photos"
    
  addFromGallery: =>
    
  addFromCamera: =>
    Ti.Media.showCamera { #TODO: GJ: can we set the orientation to force landscape? 
      success: (e) ->
        #TODO: GJ: save to temp location
        image = e.media
      cancel: ->
      error: ->
    }
