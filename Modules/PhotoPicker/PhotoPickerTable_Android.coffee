root.PhotoPicker.PhotoPickerTable_Android = class PhotoPickerTable_Android extends root.PhotoPicker.PhotoPickerTable
  constructor:(options = {}) ->
    options = root._.extend {}, options
    super options

  createToolbar: =>
    view = super()
    view.setHeight '55dp'
    view
    
  createPhotoGrid: ->
    photoGrid = super()
    photoGrid.view.setTop '55dp'
    photoGrid
  
  createCameraButton: =>
    root.app.create("Button", {
      text: "Take Photo"
      left: '10dp', top: '10dp', bottom: '10dp'
      fontSize: '12dp'
      width: '120dp', height: '35dp'
      iconSettings: {
        left: '5dp', right: '5dp'
        image: "/Common/Modules/PhotoPicker/Images/black/camera.png"
        width: '20dp', height: '20dp'
      }
      style: {
        gradient: ["#EEE", "#CECECE"]
        borderColor: "#222"
        labelShadowColor: "#FFF"
        labelColor: "#222"
      }
      onClickStyle: {
       gradient: ["#CECECE", "#EEE"]
      }
      onClick: @addFromCamera
    })
  
  createGalleryButton: =>
    root.app.create("Button", {
      text: "From Library"
      top: '10dp', right: '10dp', bottom: '10dp'
      fontSize: '12dp'
      width: '120dp', height: '35dp'
      iconSettings: {
        image: "/Common/Modules/PhotoPicker/Images/black/photos.png"
        width: '20dp', height: '20dp'
        left: '5dp', right: '5dp'
      }
      style: {
        gradient: ["#EEE", "#CECECE"]
        borderColor: "#222"
        labelShadowColor: "#FFF"
        labelColor: "#222"
      }
      onClickStyle: {
       gradient: ["#CECECE", "#EEE"]
      }
      onClick: @addFromGallery
    })