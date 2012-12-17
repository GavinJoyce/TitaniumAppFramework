root.PhotoPicker.Photo = class Photo
  constructor:(options = {}) ->
    @settings = root._.extend {
      onRemoveClick: (photo) -> 
    }, options
    
    @view = @createView()
    
    @view.add @createImageView()
    @view.add @createDeleteButton()
 
  createView: ->
    Ti.UI.createView {
      backgroundColor: '#fff'
    }
  
  createImageView: =>
    Ti.UI.createImageView @settings
  
  createDeleteButton: =>
    deleteImageView = Ti.UI.createImageView {
      top: 5, right: 5
      width: 20
      height: 20
      backgroundColor: '#C70000'
      image: root.framework.getImageResolutionUrl("/Common/Modules/PhotoPicker/Images/white/circlex.png")
    }
    deleteImageView.addEventListener("click", () =>
      dialog = Ti.UI.createAlertDialog {
        title: 'Remove Image'
        message: 'Are you sure you want to remove this image?'
        buttonNames: ['Cancel','Remove']
      }
      dialog.addEventListener 'click', (e) => 
        @settings.onRemoveClick(@) if e.index == 1
      dialog.show()
    )
    deleteImageView