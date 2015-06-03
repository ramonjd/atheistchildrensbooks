'use strict'
angular.module('acb')
.factory '$', [
  ()->
    if typeof window.jQuery is 'undefined'
      throw Error 'window.jQuery is not defined'
      $.noConflict()
    return window.jQuery
]