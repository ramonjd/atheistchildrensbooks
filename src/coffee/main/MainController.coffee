'use strict'
angular.module('acb')
.controller 'MainController', [
  '$scope'
  'MessageFactory'
  'ResizerFactory'
  ($scope, MessageFactory, ResizerFactory)->
    MessageFactory.set 'navigation', [
      {
        url : '/read'
        text : 'Read'
        id : 'read'
      }
      {
        url : '/learn'
        text : 'Learn'
        id : 'learn'
      }
      {
        url : '/about'
        text : 'About'
        id : 'about'
      }
      {
        url : '/say-hi'
        text : 'Say hi'
        id : 'sayHi'
      }
    ]

    $scope.isMenuOpen = false

    $scope.toggleNavigation = ->
      $scope.isMenuOpen = !$scope.isMenuOpen

    $scope.closeNavigation = ->
      $scope.isMenuOpen = false

    ResizerFactory.add $scope.closeNavigation

    return
]