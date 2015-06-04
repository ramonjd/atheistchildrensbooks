'use strict'
angular.module('acb')
.factory 'MessageFactory', [
  '$rootScope'
  ($rootScope)->
    api =
      set : (key, value)->
        $rootScope[key] = value
]