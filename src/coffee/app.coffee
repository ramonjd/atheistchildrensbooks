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
        pageId : 'home'
      })
      $routeProvider.when('/read', {
        templateUrl : 'templates/read.tpl.html'
        controller: 'ReadController'
        controllerAs: 'read'
        pageId : 'read'
      })
      $routeProvider.when('/read/:title', {
        templateUrl : 'templates/page.tpl.html'
        controller: 'PageController'
        controllerAs: 'read'
        pageId : 'read'
      })
      $routeProvider.when('/learn', {
        templateUrl : 'templates/learn.tpl.html'
        controller: 'LearnController'
        controllerAs: 'learn'
        pageId : 'learn'
      })
      $routeProvider.when('/about', {
        templateUrl : 'templates/about.tpl.html'
        controller: 'AboutController'
        controllerAs: 'about'
        pageId : 'about'
      })
      $routeProvider.when('/say-hi', {
        templateUrl : 'templates/say-hi.tpl.html'
        controller: 'SayHiController'
        controllerAs: 'sayHi'
        pageId : 'sayHi'
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