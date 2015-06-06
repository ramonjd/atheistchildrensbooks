'use strict'
angular.module('acb')
.directive 'loader', [
  ()->
    {
      restrict : 'A'
      templateUrl : 'templates/loader.tpl.html'
    }
]