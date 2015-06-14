'use strict'
angular.module('acb')
.directive 'guessAGod', [
  ()->
    {
    restrict : 'A'
    templateUrl : 'templates/guessagod.tpl.html'
    link : (scope, element, attrs)->

    }
]