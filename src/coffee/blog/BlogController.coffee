'use strict'
angular.module('acb')
.controller 'BlogController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'Blog - Atheist Children\'s Books'
    return
]