'use strict'
angular.module('acb')
.controller 'BlogController', [
  '$scope'
  'MessageFactory'
  'RestService'
  ($scope, MessageFactory, RestService)->
    MessageFactory.set 'title', 'Blog - Atheist Children\'s Books'
    RestService.getPage('blogPosts').then (response)->
      $scope.posts = response;
    return
]