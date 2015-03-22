((win, doc) ->->
  $body = undefined
  preloaderTimeout = 1000
  
  preLoader = ->
    imgs = [
      '/img/cloud.png'
      '/img/sun-rays.png'
      '/img/sun-centre.png'
      '/img/atheist.png'
      '/img/childrens.png'
      '/img/books.png'
      '/img/bg-clouds.png'
      '/img/star-1.png'
      '/img/star-2.png'
      '/img/star-3.png'
      '/img/star-4.png'
    ]
    a = []
    i = 0
    while i < imgs.length
      !((imgSrc, a) ->
        img = new Image

        img.onload = ->
          a.resolve()
          return
        img.src = imgSrc
        return
      )(imgs[i], a[i] = $.Deferred())
      i++
    $.when.apply($, a).done ->
      setTimeout (->
        #startup
        return
      ), preloaderTimeout
      return
    return
  return
) windwow, document