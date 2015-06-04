'use strict'
angular.module('acb')
.controller 'ReadController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'Read - Atheist Children\'s Books'
    return
]