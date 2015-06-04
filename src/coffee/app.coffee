'use strict'
angular.module('acb', [
  'ngRoute'
  'ngSanitize'
  'acb.templates',
  'acb.constants'
])
.config([
    '$routeProvider'
    '$locationProvider'
    ($routeProvider, $locationProvider)->
      # routes
      $routeProvider.when('/', {
        templateUrl : 'templates/home.tpl.html'
        controller: 'HomeController'
        controllerAs: 'home'
        title : 'Atheist Children\'s Books'
        pageId : 'home'
      })
      $routeProvider.when('/read', {
        templateUrl : 'templates/read.tpl.html'
        controller: 'ReadController'
        controllerAs: 'read'
        pageId : 'read'
      })
      $routeProvider.when('/learn', {
        templateUrl : 'templates/learn.tpl.html'
        controller: 'LearnController'
        controllerAs: 'learn'
        pageId : 'learn'
      })
      .otherwise({
          redirectTo : '/'
        })
      # nice urls thank you
      $locationProvider.html5Mode(true).hashPrefix '!'
      return
  ])
.run([
    '$rootScope'
    '$route'
    ($rootScope, $route) ->
      $rootScope.$on '$routeChangeSuccess', (newVal, oldVal)->
        if (oldVal != newVal)
          $rootScope.pageId = $route.current.pageId
      return
    ])