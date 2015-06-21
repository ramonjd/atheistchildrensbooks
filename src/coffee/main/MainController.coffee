'use strict'
angular.module('acb')
.controller 'MainController', [
  '$scope'
  'ResizerFactory'
  'LoaderFactory'
  '$timeout'
  ($scope, ResizerFactory, LoaderFactory, $timeout)->

    $scope.navigation = [
      {
        url : '/'
        text : 'Home'
        id : 'home'
      }
      {
        url : '/read'
        text : 'Read'
        id : 'read'
      }
      {
        url : '/about'
        text : 'About'
        id : 'about'
      }
      {
        url : '/blog'
        text : 'Blog'
        id : 'blog'
      }
    ]

    $scope.isMenuOpen = false

    $scope.toggleNavigation = ->
      $scope.isMenuOpen = !$scope.isMenuOpen

    $scope.closeNavigation = ->
      $scope.isMenuOpen = false

    ResizerFactory.add $scope.closeNavigation

    finishLoading = ->
      $scope.loadingFinished = true
      $timeout ()->
        $scope.hideLoader = true
        $scope.showSiteHeader = true
        $timeout ()->
          $scope.isPageLoaded = true
          return
        , 1250
        return
      , 750

    LoaderFactory.load {
      onStep: (Percent)->
        $timeout ()->
          $scope.percentageComplete = Percent
        return
      onComplete: ()->
        finishLoading()
    }

    return
]