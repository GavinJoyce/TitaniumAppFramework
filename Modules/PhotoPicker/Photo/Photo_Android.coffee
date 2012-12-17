root.PhotoPicker.Photo_Android = class Photo_Android extends root.PhotoPicker.Photo
  constructor:(options = {}) ->
    super root._.extend {}, options
    
  createDeleteButton: ->
    deleteImageView = super()
    deleteImageView.setTop '5dp'
    deleteImageView.setRight '5dp'
    deleteImageView.setWidth '20dp'
    deleteImageView.setHeight '20dp'
    deleteImageView

  createView: ->
    view = super()
    view.setTop '5dp'
    view.setRight '5dp'
    view.setWidth '100dp'
    view.setHeight '100dp'
    view
    
  createImageView: =>
    image = super()
    image.setWidth '90dp'
    image.setHeight '90dp'
    image.image = @settings.thumb
    image.thumb = @settings.thumb
    image.filename = @settings.filename
    image