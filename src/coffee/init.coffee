acb.init = ((win, doc, $, pageSlide) ->
  $body = $ 'body'
  swiper = undefined
  $logoImgs = $ '.logo h1 > img'
  $arrows = $ '.arrow'
  $sun = $ '.sun'
  $cloud = $ '.cloud'
  $clouds = $ '.bg-clouds'
  $balloon = $ '.questions-corner'
  $footerLinks = $ 'footer nav a'
  $close = $ '.close'
  $overlay = $ '.overlay'
  $loading = $ '.loading'
  animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'

  animateLogo = ->
    setTimeout ()->
      $logoImgs.toggleClass 'zoomInDown animated'
      $sun.toggleClass 'bounceIn animated'
      setTimeout ()->
        $balloon.toggleClass 'lightSpeedIn animated'
      , 250
    , 750
    setTimeout ()->
      $clouds.toggleClass 'bounceIn animated'
    , 250
    $cloud.toggleClass 'bounceIn animated'
    return

  finishLoading = ->
    $loading.addClass 'loaded'
    setTimeout ()->
      $loading.addClass 'hide'
      animateLogo()
      setTimeout ()->
        $body.addClass 'loaded'
        $loading.removeClass 'loaded hide'
      , 1250
    , 750

  attachEvents = ->
    $arrows.mouseenter ()->
      $(this).toggleClass 'shake animated'
      $arrows.one animationEnd, (e)->
        $(e.target).removeClass 'shake animated'
        return
      return
    $footerLinks.mouseenter ()->
      $(this).toggleClass 'rubberBand animated'
      $footerLinks.one animationEnd, (e)->
        $(e.target).removeClass 'rubberBand animated'
        return
      return
    $close.click ()->
      $overlay.removeClass 'bounceIn animated'
      $overlay.removeClass 'show'
    $balloon.click ()->
      $overlay.addClass 'show'
      $overlay.addClass 'bounceIn animated'
    return

  # init app
  attachEvents()
  pageSlide.init()

  # loading
  $body.preloadImages {
    onStep: ()->
      return
    onComplete: ()->
      finishLoading()
  }

  return
) window, document, jQuery, acb.pageSlide