#https://marketplace.appcelerator.com/apps/794?2141993224
#http://developer.apple.com/library/ios/#documentation/NetworkingInternet/Conceptual/StoreKitGuide/DevelopingwithStoreKit/DevelopingwithStoreKit.html

root.Commerce.StoreKit = class StoreKit
  constructor: ->
    @tiStorekit = require('ti.storekit')
     
  canMakePayments: -> @tiStorekit.canMakePayments
  
  getProduct: (indentifier, options = {}) ->
    @tiStorekit.requestProducts [indentifier], (e) ->
      if !e.success
        options.onError(e) if options.onError?
      else if e.invalid
        options.onInvalidProduct(e) if options.onInvalidProduct?
      else
        options.onSuccess(e.products[0]) if options.onSuccess?
        
  purchase: (product, options = {}) =>
    @tiStorekit.purchase product, (e) =>
      Ti.API.info('root.Commerce.StoreKit : purchase -- reply') 
      switch e.state
        when @tiStorekit.FAILED then options.onFailed(product) if options.onFailed
        when @tiStorekit.PURCHASED then options.onPurchased(product) if options.onPurchased
        when @tiStorekit.RESTORED then options.onRestored(product) if options.onRestored
    
  
