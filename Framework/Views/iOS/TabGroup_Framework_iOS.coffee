root.TabGroup_Framework_iOS = class TabGroup_Framework_iOS
  constructor:(options = {}) ->
    options = root._.extend({
      views: [
        {
          View: ""
          Callback: null
          Tab: {
            Name: "Tab 1"
            Icon: ""
          }
        }
      ]
    }, options)
    
    @tabs = Ti.UI.createTabGroup()
    
    for view in options.views
      tab = Ti.UI.createTab({
        title: view.Tab.Name
        icon: view.Tab.Icon
        window: view.View.window
      })
      @tabs.addTab(tab)
      if view.Callback?
        tab.addEventListener("click", view.Callback)


  setActiveTab: (index) -> @tabs.setActiveTab(index)