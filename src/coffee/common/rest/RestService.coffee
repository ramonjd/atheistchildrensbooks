'use strict'
angular.module('acb')
.service 'RestService', [
  '$http'
  'ENV'
  'loadingFactory'
  ($http, ENV, loadingFactory)->
    deferred = null
    success = (res)->
      loadingFactory.hide()
      res.data
    error = (res)->
      loadingFactory.hide()
      res.data
    @getPage = (pageName)->
      loadingFactory.show()
      req = $http.get ENV.BASE + ENV.URLS[pageName], {cache:true}
      req.then success, error
    return
]