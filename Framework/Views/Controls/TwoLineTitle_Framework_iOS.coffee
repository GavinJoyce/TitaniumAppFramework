root.TwoLineTitle_Framework_iOS = class TwoLineTitle_Framework_iOS extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options

  createTitle: =>
    title = super
    title.updateLayout { 
      setminimumFontSize : 13
      shadowColor: '#222'
      shadowOffset: { x: 0, y: -1 }
    }
    
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
      setminimumFontSize : 15
      shadowColor: '#222'
      shadowOffset: { x: 0, y: -1 }
    }
    
    bigTitle