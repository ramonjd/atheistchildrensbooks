(($, sr) ->
  # debouncing function from John Hann
  # http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/

  debounce = (func, threshold, execAsap) ->
    timeout = undefined
    ->
      obj = this
      args = arguments

      delayed = ->
        if !execAsap
          func.apply obj, args
        timeout = null
        return

      if timeout
        clearTimeout timeout
      else if execAsap
        func.apply obj, args
      timeout = setTimeout(delayed, threshold or 100)
      return

  # smartresize

  jQuery.fn[sr] = (fn) ->
    if fn then @bind('resize', debounce(fn)) else @trigger(sr)

  return
) jQuery, 'smartresize'