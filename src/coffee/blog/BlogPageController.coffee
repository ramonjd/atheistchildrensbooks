'use strict'
angular.module('acb')
.controller 'BlogPageController', [
  '$scope'
  'MessageFactory'
  'RestService'
  '$routeParams'
  ($scope, MessageFactory, RestService, $routeParams)->
    RestService.getPost($routeParams.postId).then (response)->
      $scope.post = response;
      MessageFactory.set 'title', 'Blog - Atheist Children\'s Books - ' + $scope.post.title
    return
]