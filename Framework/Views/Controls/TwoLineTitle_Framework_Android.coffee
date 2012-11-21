root.TwoLineTitle_Framework_Android = class TwoLineTitle_Framework_Android extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options
    
  createTitle: =>
    title = super()
    title.setHeight 'auto'
    title.setFont { fontSize: 22 }
    title
    
  createSubTitle: =>
    subTitle = super()
    subTitle.setHeight 'auto'
    subTitle.setFont { fontSize: 18 }
    subTitle
  
  createBigTitle: =>
    bigTitle = super()
    bigTitle.setHeight 'auto'
    bigTitle.setFont { fontSize: 28, fontWeight: 'bold' }
    
    bigTitle