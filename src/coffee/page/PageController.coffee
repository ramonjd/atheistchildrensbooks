'use strict'
angular.module('acb')
.controller 'PageController', [
  '$scope'
  'MessageFactory'
  '$routeParams'
  ($scope, MessageFactory, $routeParams)->
    MessageFactory.set 'title', 'Book title - Read - Atheist Children\'s Books'
    console.log $routeParams
    return
]