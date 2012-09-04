root.PhotoPicker.Photo = class Photo
  constructor:(options = {}) ->
    @settings = root._.extend({
      width: 140
      height: 100
      onRemoveClick: (photo) -> 
    }, options)
    @view = Ti.UI.createView @settings
    @view.addEventListener 'click', => 
      dialog = Ti.UI.createAlertDialog {
        title: 'Remove Image'
        message: 'Are you sure you want to remove this image?'
        buttonNames: ['Cancel','Remove']
      }
      dialog.addEventListener 'click', (e) => 
        @settings.onRemoveClick(@) if e.index == 1
      dialog.show()
      
    @image = Ti.UI.createImageView @settings
    @view.add @image
    
    @remove = Ti.UI.createView {
      right: 5
      top: 5
      width: 25
      height: 25
      backgroundColor: '#333'
    }
    
    @view.add @remove
  