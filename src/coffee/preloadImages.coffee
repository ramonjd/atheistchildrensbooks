(($) ->

  items = new Array
  current = 0

  ### Callbacks ###
  onStep = (Percent) ->

  onComplete = ->

  # Get all images from css and <img> tag
  getImages = (element) ->
    $(element).find('*:not(script)').each ->
      url = ''
      if $(this).css('background-image').indexOf('none') == -1 and $(this).css('background-image').indexOf('-gradient') == -1
        url = $(this).css('background-image')
        if url.indexOf('url') != -1
          temp = url.match(/url\((.*?)\)/)
          url = temp[1].replace(/\"/g, '')
      else if $(this).get(0).nodeName.toLowerCase() == 'img' and typeof $(this).attr('src') != 'undefined'
        url = $(this).attr('src')
      if url.length > 0
        items.push url
      return
    return

  loadComplete = ->
    current++
    onStep Math.round(current / items.length * 100)
    if current == items.length
      onComplete()
    return

  loadImg = (url) ->
    $(new Image).load(loadComplete).error(loadComplete).attr 'src', url
    return

  $.fn.preloadImages = (options) ->
    @each ->
      ### Set Callbacks ###
      if typeof options.onStep != 'undefined'
        onStep = options.onStep
      if typeof options.onComplete != 'undefined'
        onComplete = options.onComplete
      getImages this
      i = 0
      while i < items.length
        loadImg items[i]
        i++
      return
) jQuery