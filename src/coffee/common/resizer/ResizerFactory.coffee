'use strict'
angular.module('acb')
.factory 'ResizerFactory', [
  '$timeout'
  '$window'
  ($timeout, $window)->
    callbacks = []
    running = false

    resize = ->
      if !running
        running = true
        if $window.requestAnimationFrame
          $timeout ->
            $window.requestAnimationFrame runCallbacks
          , 0
        else
          $timeout runCallbacks, 66
      return

    runCallbacks = ->
      callbacks.forEach (callback) ->
        callback()
        return
      running = false
      return

    addCallback = (callback) ->
      if callback
        callbacks.push callback
      return

    api =
      add : (callback) ->
        if !callbacks.length
          $window.addEventListener 'resize', resize
        addCallback callback
        return
]