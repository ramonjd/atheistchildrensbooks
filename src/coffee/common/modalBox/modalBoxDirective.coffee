'use strict'
angular.module('acb')
.directive 'modalBox', [
  '$'
  ($)->
    {
    restrict : 'A'
    replace : true
    templateUrl : 'templates/modalbox.tpl.html'
    scope:
      isModalBoxOpen : '='
    link : (scope)->
      scope.closeModal = ()->
        scope.isModalBoxOpen = false;
    }
]