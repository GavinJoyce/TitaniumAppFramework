root.HeadsUp.HeadsUpMessage = class HeadsUpMessage
  constructor:(options = {}) ->
    @isOpen = false
    @window = Ti.UI.createWindow {
      height: 50
      width: 300
      bottom: 10
      borderRadius: 10
      touchEnabled: false
      zIndex: 999
    }
    
    @view = Ti.UI.createView {
      height:30
      width:250
      borderRadius:10
      backgroundColor:'#000'
      opacity:0.7
      touchEnabled:false
    }
    
    @label = Ti.UI.createLabel {
    	text: ''
    	color:'#fff'
    	width:250
    	height:'auto'
  		font: {
  			fontFamily:'Helvetica Neue'
  			fontSize:13
  		}
  		textAlign:'center'
    }
    
    @window.add @view
    @window.add @label
    
    Ti.App.addEventListener 'HeadsUp.HeadsUpMessage.update', (data) => @update data.message, data.progress
    Ti.App.addEventListener 'HeadsUp.HeadsUpMessage.close', (data) => @close()
    
  open: -> 
    unless isOpen
      @window.open()
      isOpen = true
  close: -> 
    @label.text = ''
    @window.close()
    isOpen = false
  
  flash: (message, duration = 1000) ->
    @label.text = message
    @open()
    
    root.app.delay duration, => @close { opacity:0, duration:500 }
    
  update: (message, progress = null) ->
    @open()
    @label.text = message + "(#{progress})"
    #TODO: GJ: set progress bar
    