root.TwoLineTitle_Framework_Android = class TwoLineTitle_Framework_Android extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options
    
    @view.setWidth '50%'
    
  createTitle: =>
    title = super()
    title.setHeight 'auto'
    title.setFont { fontSize: '16dp' }
    title
    
  createSubTitle: =>
    subTitle = super()
    subTitle.setHeight 'auto'
    subTitle.setFont { fontSize: '14dp' }
    subTitle
  
  createBigTitle: =>
    bigTitle = super()
    bigTitle.setFont { fontSize: '18dp' }
    
    bigTitle