acb.init = ((window, $, pageSlide) ->
  $body = $ 'body'
  $win = $ window
  $stage = $ '.stage'
  $logoImgs = $ '.logo-wrapper > img'
  $arrows = $ '.arrow'
  $sun = $ 'div.sun'
  $cloud = $ '.cloud'
  $clouds = $ '.bg-clouds'
  $balloon = $ '.questions-corner'
  $footerLinks = $ 'footer nav a'
  $close = $ '.close'
  $overlay = $ '.overlay'
  $loading = $ '.loading'
  $menuTitle = $ '.menu-title span'
  $darkClouds = $ '.dark-clouds'
  $sayHi = $ '#say-hi'
  animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
  isMenuOpen = false
  isSpaceOpen = false

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

  toggleMenu = (state) ->
    if state is false && isMenuOpen is false
      return isMenuOpen
    if isMenuOpen or state is false
      $body.removeClass 'menu-open shadow'
      isMenuOpen = false
    else
      $body.addClass 'menu-open shadow'
      isMenuOpen = true
    isMenuOpen

  toggleSpace = (state) ->
    if isSpaceOpen is true or state is false
      $sayHi.removeClass 'space'
      $body.removeClass 'space-open'
      $darkClouds.removeClass 'show'
      isSpaceOpen = false
      $('html, body').animate {scrollTop: 0}, 'slow'
    else
      $sayHi.toggleClass 'space'
      $body.toggleClass 'space-open'
      $darkClouds.toggleClass 'show'
      isSpaceOpen = $sayHi.hasClass 'space'

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

    $close.on 'click', ()->
      $overlay.removeClass 'bounceIn animated'
      $overlay.removeClass 'show'
      $body.removeClass 'shadow'

    $balloon.on 'click', ()->
      toggleSpace()

    $menuTitle.on 'click', ()->
      toggleMenu()

    $stage.on 'click', (e)->
      $target = $ e.target
      if isMenuOpen and $target[0] != $menuTitle[0]
        toggleMenu()
      if isSpaceOpen is true and $target.parents('#say-hi').length is 0 and $target.parents('.questions-corner').length is 0
        toggleSpace(false)

    return

  # init app
  attachEvents()
  $win.smartresize ()->
    toggleMenu(false)

  # loading
  $body.preloadImages {
    onStep: ()->
      return
    onComplete: ()->
      finishLoading()
  }

  return
) window, jQuery