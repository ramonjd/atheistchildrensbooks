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
          document.title = $route.current.title
          $rootScope.pageId = $route.current.pageId
      return
    ])