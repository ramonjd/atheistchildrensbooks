'use strict'
angular.module('acb')
.factory 'UtilsFactory', [
  ()->
    api =
      random : (min, max)->
        Math.floor Math.random() * ((max-min)+1) + min
]