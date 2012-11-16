root.TwoLineTitle_Framework = class TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend({}, options)
    
    @view = Ti.UI.createView {
      top: 0
      width: Ti.UI.FILL
      height: Ti.UI.FILL
    }
    
    @title = @createTitle()
    @subtitle = @createSubTitle()
    @bigtitle = @createBigTitle()
    @bigtitle.hide()

    @view.add @title
    @view.add @subtitle
    @view.add @bigtitle
    @view.addEventListener('click', (e) => options.onClick(e) if options.onClick)
  
  createTitle: ->
    Ti.UI.createLabel {
      color: '#FFF'
      height: 18
      width: Ti.UI.FILL
      top: 5
      text: ' '
      textAlign: 'center'
      font: { fontSize: 15, fontWeight: 'bold' }
    }
  
  createSubTitle: ->
    Ti.UI.createLabel {
      color:'#FFF'
      height: 14
      width: Ti.UI.FILL
      bottom: 7
      text: ' '
      textAlign: 'center'
      font: { fontSize: 11, fontWeight: 'bold' }
    }
  
  createBigTitle: ->
    Ti.UI.createLabel {
      color:'#FFF'
      height: 20
      width: Ti.UI.FILL
      text: ' '
      textAlign: 'center'
      font: { fontSize: 17, fontWeight: 'bold' }
    }
  
  update: (title, subtitle) ->
    if !subtitle? || subtitle == ''
      @title.hide()
      @subtitle.hide()
      @bigtitle.show()
    else
      @title.show()
      @subtitle.show()
      @bigtitle.hide()
    
    @title.text = title
    @bigtitle.text = title
    @subtitle.text = subtitle

  clear: =>
    @update('', null)