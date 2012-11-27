root.TwoLineTitle_Framework = class TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {
      title: null
      subTitle: null
    }, options
    
    @view = Ti.UI.createView {
      top: 0
      width: '60%', height: Ti.UI.SIZE
    }
    
    @title = @createTitle()
    @subtitle = @createSubTitle()
    @bigtitle = @createBigTitle()

    @view.add @title
    @view.add @subtitle
    @view.add @bigtitle
    @view.addEventListener('click', (e) => options.onClick(e) if options.onClick)
    
    @update(options.title, options.subTitle)
    
  createTitle: ->
    Ti.UI.createLabel {
      color: '#FFF'
      height: 18
      width: Ti.UI.SIZE
      top: 5
      text: ' '
      textAlign: 'center'
      font: { fontSize: 15, fontWeight: 'bold' }
    }
  
  createSubTitle: ->
    Ti.UI.createLabel {
      color:'#FFF'
      height: 14
      width: Ti.UI.SIZE
      bottom: 7
      text: ' '
      textAlign: 'center'
      font: { fontSize: 11, fontWeight: 'bold' }
    }
  
  createBigTitle: ->
    Ti.UI.createLabel {
      color:'#FFF'
      height: '100%'
      width: Ti.UI.SIZE
      text: ' '
      textAlign: 'center'
      font: { fontSize: 17, fontWeight: 'bold' }
    }
  
  update: (title, subtitle) =>
    if !subtitle? || subtitle == ''
      @title.setText ' '
      @subtitle.setText ' '
      @bigtitle.setText title
    else
      @title.setText title
      @subtitle.setText subtitle
      @bigtitle.setText ' '

  clear: =>
    @update('', null)