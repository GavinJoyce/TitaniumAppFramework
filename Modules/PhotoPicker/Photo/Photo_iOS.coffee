root.PhotoPicker.Photo_iOS = class Photo_iOS extends root.PhotoPicker.Photo
  constructor:(options = {}) ->
    super root._.extend {}, options
    
  createDeleteButton: ->
    deleteImageView = super()
    deleteImageView.updateLayout {
      borderRadius: 10
      borderWidth: 1
      borderColor: '#C70000'
    }
    deleteImageView