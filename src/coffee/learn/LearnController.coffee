'use strict'
angular.module('acb')
.controller 'LearnController', [
  '$scope'
  'MessageFactory'
  ($scope, MessageFactory)->
    MessageFactory.set 'title', 'Learn - Atheist Children\'s Books'
    return
]