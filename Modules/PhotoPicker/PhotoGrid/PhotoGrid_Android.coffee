root.PhotoPicker.PhotoGrid_Android = class PhotoGrid_Android extends root.PhotoPicker.PhotoGrid
  constructor:(options = {}) ->
    super root._.extend {}, options
    
  createPlaceHolderLabel: ->
    label = super()
    label.setFont { fontSize: '18dp' }
    label