root.TwoLineTitle_Framework_Android = class TwoLineTitle_Framework_Android extends root.TwoLineTitle_Framework
  constructor: (options = {}) ->
    options = root._.extend {}, options
    super options
    
    @view.setWidth '70%'
    
  createTitle: =>
    title = super()
    title.setTop '5dp'
    title.setHeight '20dp'
    title.setFont { fontSize: '15dp' }
    title.setEllipsize true
    title
    
  createSubTitle: =>
    subTitle = super()
    subTitle.setTop '25dp'
    subTitle.setHeight '20dp'
    subTitle.setFont { fontSize: '13dp' }
    subTitle.setEllipsize true
    subTitle
  
  createBigTitle: =>
    bigTitle = super()
    bigTitle.setHeight 'auto'
    bigTitle.setFont { fontSize: '17dp' }
    bigTitle.setEllipsize true
    
    bigTitle