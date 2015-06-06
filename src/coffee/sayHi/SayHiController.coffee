'use strict'
angular.module('acb')
.controller 'SayHiController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'Say Hi - Atheist Children\'s Books'
    return
]