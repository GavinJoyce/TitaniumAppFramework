root.PhotoPicker.Photo_iPad = class Photo_iPad extends root.PhotoPicker.Photo
  constructor:(options = {}) ->
    @settings = root._.extend({}, options)
    
    @view = Ti.UI.createView({
      height: 182
      width: 182
      left: 8
      bottom: 8
      backgroundColor: "#FFF"
      borderWidth: 1
      borderColor: "#CCC"
    })
    @image = Ti.UI.createImageView({
      height: 172
      width: 172
      image: @settings.thumb
      thumb: @settings.thumb
      filename: @settings.filename
    })
    @view.add(@image)
    
    @view.add(@createRemoveButton())