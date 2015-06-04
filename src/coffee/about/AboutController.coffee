'use strict'
angular.module('acb')
.controller 'AboutController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'About - Atheist Children\'s Books'
    return
]