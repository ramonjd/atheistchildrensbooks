'use strict'
angular.module('acb')
.service 'RestService', [
  '$http'
  'ENV'
  ($http, ENV)->
    success = (res)->
      res.data
    error = (res)->
      res.data
    @getPage = (pageName)->
      req = $http.get ENV.BASE + ENV.URLS[pageName], {cache:true}
      req.then success, error
    @getPost = (postId)->
      req = $http.get ENV.BASE + ENV.URLS.posts + postId , {cache:true}
      req.then success, error
    return
]