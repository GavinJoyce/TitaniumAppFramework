root.TwoLineTitle_Framework_iOS = class TwoLineTitle_Framework_iOS extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options

  createTitle: =>
    title = super
    title.updateLayout { 
      shadowColor: '#222'
      shadowOffset: { x: 0, y: -1 }
    }
    title.setMinimumFontSize 13
    
    title
    
  createSubTitle: =>
    subTitle = super
    subTitle.updateLayout { 
      shadowColor: '#222'
      shadowOffset: { x: 0, y: -1 }
    }
    
    subTitle
  
  createBigTitle: =>
    bigTitle = super
    bigTitle.updateLayout { 
      shadowColor: '#222'
      shadowOffset: { x: 0, y: -1 }
    }
    bigTitle.setMinimumFontSize 15
    
    bigTitle