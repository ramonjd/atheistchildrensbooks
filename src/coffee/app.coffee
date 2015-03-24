((win, doc, $) ->
  $body = undefined
  swiper = undefined
  $logoImgs = $ '.logo h1 > img'
  $arrows = $ '.arrow'
  $cloud = $ '.cloud'
  preloaderTimeout = 1
  
  
  animateLogo = ->
    setTimeout ()->
      $logoImgs.toggleClass 'zoomInDown animated'
    , 750
    $cloud.toggleClass 'bounceIn animated'
    return
    
  
  attachEvents = ->
    $arrows.mouseenter ()->
      $(this).toggleClass 'shake animated'
      $arrows.one 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', (e)->
        $(e.target).removeClass 'shake animated'
        return
      return
    return
  
  setupSwiper = ->
    swiper = new Swiper '.swiper-container', {
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
    }
  
  preLoader = ->
    imgs = [
      '/img/question.png'
      '/img/balloon.png'
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
        animateLogo()
        attachEvents()
        return
      ), preloaderTimeout
      return
    return
  

  preLoader()
  return
  
) window, document, jQuery