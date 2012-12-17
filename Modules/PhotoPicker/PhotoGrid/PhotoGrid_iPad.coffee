root.PhotoPicker.PhotoGrid_iPad = class PhotoGrid_iPad extends root.PhotoPicker.PhotoGrid
  constructor: (options = {}) ->
    super root._.extend {
      width: 768
      contentWidth: 768
    }, options