root.TwoLineTitle_Framework_Android = class TwoLineTitle_Framework_Android extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options
    
  createTitle: =>
    title = super
    title.updateLayout {
      height: Ti.UI.SIZE
      font: { fontSize: 22 }
    }
    
    title
    
  createSubTitle: =>
    subTitle = super
    subTitle.updateLayout {
      height: Ti.UI.SIZE
      font: { fontSize: 18 }
    }
    
    subTitle
  
  createBigTitle: =>
    bigTitle = super
    bigTitle.updateLayout {
      height: Ti.UI.SIZE
      font: { fontSize: 28, fontWeight: 'bold' }
    }
    
    bigTitle