root.PhotoPicker.Photo_iPhone = class Photo_iPhone extends root.PhotoPicker.Photo_iOS
  constructor:(options = {}) ->
    super root._.extend {}, options
    
  createView: ->
    view = super()
    view.updateLayout {
      left: 5, top: 5
      width: 100, height: 100
      backgroundColor: "#FFF"
      borderWidth: 1
      borderColor: "#CCC"
    }
    view
    
  createImageView: =>
    image = super()
    image.updateLayout {
      height: 90
      width: 90
      image: @settings.thumb
      thumb: @settings.thumb
    }
    image.filename = @settings.filename
    image