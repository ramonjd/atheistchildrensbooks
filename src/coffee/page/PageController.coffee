'use strict'
angular.module('acb')
.controller 'PageController', [
  '$scope'
  'MessageFactory'
  '$routeParams'
  ($scope, MessageFactory, $routeParams)->
    MessageFactory.set 'title', $routeParams.title + ' - Read - Atheist Children\'s Books'
    $scope.pageTitle = $routeParams.title
    return
]