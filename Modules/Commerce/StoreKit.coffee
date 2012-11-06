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
        
  
        
  purchase: (identifier, options = {}) =>
    options = root._.extend({
      onInvalidProduct: ->
      onError: ->
      onPurchased: ->
      onRestored: ->
    }, options)
    
    @getProduct identifier, {
      onSuccess: (product) =>
        @purchaseProduct product, {
          onFailed: options.onError
          onPurchased: options.onPurchased
          onRestored: options.onRestored
        }
      onError: options.onError
      onInvalidProduct: options.onInvalidProduct
    }
    
  purchaseProduct: (product, options = {}) =>
    @tiStorekit.purchase product, (e) =>
      Ti.API.info('root.Commerce.StoreKit : purchase -- reply') 
      switch e.state
        when @tiStorekit.FAILED then options.onFailed(e, product) if options.onFailed
        when @tiStorekit.PURCHASED then options.onPurchased(e, product) if options.onPurchased
        when @tiStorekit.RESTORED then options.onRestored(e, product) if options.onRestored
    
    
  
