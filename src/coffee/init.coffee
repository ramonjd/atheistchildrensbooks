acb.init = ((window, $, pageSlide) ->
  $body = $ 'body'
  $win = $ window
  $stage = $ '.stage'
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
  $menuTitle = $ '.menu-title'
  $navLinks = $ 'nav a'
  $header = $ 'header'
  animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
  swiper = undefined
  isMenuOpen = false

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
      $body.removeClass 'menu-open'
      isMenuOpen = false
    else
      $body.addClass 'menu-open'
      isMenuOpen = true
    isMenuOpen

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
    $balloon.on 'click', ()->
      $overlay.addClass 'show'
      $overlay.addClass 'bounceIn animated'
    $menuTitle.on 'click', ()->
      toggleMenu()
    $stage.on 'click', (e)->
      target = e.target
      if isMenuOpen and target != $menuTitle[0]
        toggleMenu()

    $navLinks.on 'click', (e)->
      e.preventDefault()
      $this = $ this
      $navLinks.removeClass 'active'
      if ($this.attr('data-slide-index') && !swiper.animating)
        swiper.slideTo $this.attr('data-slide-index')
        $this.addClass 'active'
      if $this.parent('li').hasClass 'say-hi'
        if $header.hasClass 'space'
          $this.removeClass 'active'
        else
          $this.addClass 'active'
        $header.toggleClass 'space'
      else
        $header.removeClass 'space'
    return

  # init app
  attachEvents()
  pageSlide.init()
  swiper = pageSlide.getSwiper()
  $win.smartresize ()->
    pageSlide.resizeContainer()
    toggleMenu(false)

  # loading
  $body.preloadImages {
    onStep: ()->
      return
    onComplete: ()->
      finishLoading()
  }

  return
) window, jQuery, acb.pageSlide