acb.pageSlide = ((win, per, $) ->
  swiper = undefined
  swiperV = undefined
  $swiperContainer = $ '.swiper-container'
  $win = $ win
  $navLinks = $ 'nav a'

  setActiveSlide = (index)->
    $navLinks.removeClass('active').eq(index).addClass('active')

  resizeContainer = ->
    h = $win.height();
    if (h > 600)
      $swiperContainer.height h

  setupNavLinks = ->
    $navLinks.on 'click', (e)->
      e.preventDefault()
      $this = $ this
      if ($this.attr('data-slide-index') && !swiper.animating)
        swiper.slideTo $this.attr('data-slide-index')
        $navLinks.removeClass 'active'
        $this.addClass 'active'

  setupSwiper = ->
    swiper = new Swiper '.swiper-container-h', {
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
      hashnav: true
      setWrapperSize: true
      keyboardControl: true
      onSlideChangeEnd : (swiperObject)->
        setActiveSlide(swiperObject.activeIndex)
    }
    swiperV = new Swiper '.swiper-container-v', {
      pagination: '.swiper-pagination-v'
      paginationClickable: true
      direction: 'vertical'
      keyboardControl: true
      hashnav: true
    }
    setupNavLinks()
    resizeContainer()

  return {
    init : setupSwiper
    swiper : swiper
    resizeContainer : resizeContainer
  }
) window, window.Swiper, jQuery