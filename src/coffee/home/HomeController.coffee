'use strict'
angular.module('acb')
.controller 'HomeController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'Home - Atheist Children\'s Books'
    return
]