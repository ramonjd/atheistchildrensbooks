acb.pageSlide = ((win, per, $) ->
  swiper = undefined
  $swiperContainer = $ '.swiper-container-h'
  $win = $ win
  $navLinks = $ 'nav a'
  slideTimeout = undefined

  setActiveSlide = (index)->
    clearTimeout slideTimeout
    slideTimeout = setTimeout ->
      $navLinks.removeClass('active').eq(index).addClass 'active'
    , 250
  resizeContainer = ->
    h = $win.height();
    if (h > 600)
      $swiperContainer.height h

  setupSwiper = ->
    swiper = new Swiper '.swiper-container-h', {
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
      hashnav: true
      setWrapperSize: true
      keyboardControl: true
      parallax: true
      onTransitionEnd: (swiperObject)->
        setActiveSlide(swiperObject.activeIndex)
    }
    resizeContainer()

  return {
  init: setupSwiper
  getSwiper: ->
    swiper
  resizeContainer: resizeContainer
  }) window, window.Swiper, jQuery