'use strict'
angular.module('acb')
.factory 'LoaderFactory', [
  'IMGS'
  (IMGS)->

    current = 0

    ### Callbacks ###
    onStep = (Percent) ->
      return

    onComplete = ->
      return

    loadComplete = ->
      current++
      onStep Math.round(current / IMGS.length * 100)
      if current == IMGS.length
        onComplete()
      return

    loadImg = (url) ->
      $(new Image).load(loadComplete).error(loadComplete).attr 'src', url
      return

    api =
      load : (options)->
        ### Set Callbacks ###
        if typeof options.onStep != 'undefined'
          onStep = options.onStep
        if typeof options.onComplete != 'undefined'
          onComplete = options.onComplete
        i = 0
        while i < IMGS.length
          loadImg IMGS[i]
          i++
        return
]