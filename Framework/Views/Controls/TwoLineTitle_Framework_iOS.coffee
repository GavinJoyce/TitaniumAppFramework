root.TwoLineTitle_Framework_iOS = class TwoLineTitle_Framework_iOS
  constructor: (options = {}) ->
    options = root._.extend({}, options)
    
    @title = Ti.UI.createLabel({
      color: '#FFF'
      height: 18
      width: Ti.UI.FILL
      top: 5
      text: ' '
      textAlign: 'center'
      font: { fontSize: 15, fontWeight: 'bold' }
      minimumFontSize: 13
      shadowColor: '#222', shadowOffset: { x: 0, y: -1 }
      wordWrap: false
      ellipsize: true
    })
    
    @subtitle = Ti.UI.createLabel({
      color:'#FFF'
      height: 14
      width: Ti.UI.FILL
      bottom: 5
      text: ' '
      textAlign: 'center'
      font: { fontSize: 11, fontWeight: 'bold' }
      shadowColor: '#222', shadowOffset: { x: 0, y: -1 }
    })
    
    @bigtitle = Ti.UI.createLabel({
      color:'#FFF'
      height: 20
      width: Ti.UI.FILL
      text: ' '
      textAlign: 'center'
      font: { fontSize: 17, fontWeight: 'bold' }
      minimumFontSize: 15
      shadowColor: '#222', shadowOffset: { x: 0, y: -1 }
    })
    @bigtitle.hide()
    
    @view = Ti.UI.createView({
      top: 0
      width: Ti.UI.FILL
      height: Ti.UI.FILL
    })
    @view.add(@title)
    @view.add(@subtitle)
    @view.add(@bigtitle)
    
    @view.addEventListener('click', (e) => options.onClick(e) if options.onClick)
    
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