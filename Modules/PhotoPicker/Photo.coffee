root.PhotoPicker.Photo = class Photo
  constructor:(options = {}) ->
    @settings = root._.extend({
      onRemoveClick: (photo) -> 
    }, options)
    
    @view = Ti.UI.createView()
    @image = Ti.UI.createImageView(@settings)
    @view.add(@image)
    
    @view.add(@createRemoveButton())
    
  createRemoveButton: =>
    ###
      SS: Added this as a function to get around an issue with passing around '@' in the click event
      but still allows us to re-use in controls that extend, e.g. 'Photo_iPhone'
    ###
    @remove = Ti.UI.createView {
      right: 5
      top: 5
      width: 15
      height: 15
      backgroundColor: '#333'
    }
    @view.add(@remove)
    @remove.addEventListener("click", () =>
      dialog = Ti.UI.createAlertDialog {
        title: 'Remove Image'
        message: 'Are you sure you want to remove this image?'
        buttonNames: ['Cancel','Remove']
      }
      dialog.addEventListener 'click', (e) => 
        @settings.onRemoveClick(@) if e.index == 1
      dialog.show()
    )
    
    @remove