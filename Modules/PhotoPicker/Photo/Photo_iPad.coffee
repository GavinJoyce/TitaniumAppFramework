root.PhotoPicker.Photo_iPad = class Photo_iPad extends root.PhotoPicker.Photo_iOS
  constructor:(options = {}) ->
    super root._.extend({}, options)
  
  createView: ->
    view = super()
    view.updateLayout {
      left: 8, top: 8
      width: 182, height: 182
      backgroundColor: "#FFF"
      borderWidth: 1
      borderColor: "#CCC"
    }
    view
    
  createImageView: =>
    image = super()
    image.updateLayout {
      height: 172
      width: 172
      image: @settings.thumb
      thumb: @settings.thumb
    }
    image.filename = @settings.filename
    image