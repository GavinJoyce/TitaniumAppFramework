root.PhotoPicker.Photo_iPhone = class Photo_iPhone extends root.PhotoPicker.Photo
  constructor:(options = {}) ->
    @settings = root._.extend({}, options)
    
    @view = Ti.UI.createView({
      height: 100
      width: 100
      left: 5
      bottom: 5
      backgroundColor: "#FFF"
      borderWidth: 1
      borderColor: "#CCC"
    })
    @image = Ti.UI.createImageView({
      height: 90
      width: 90
      image: @settings.thumb
      thumb: @settings.thumb
      filename: @settings.filename
    })
    @view.add(@image)
    
    @view.add(@createRemoveButton())