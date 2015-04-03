acb.pageSlide = ((Swiper, $) ->
  swiper = undefined
  $navLinks = $ 'footer a'

  setActiveSlide = (index)->
    $navLinks.removeClass('active').eq(index).addClass('active')


  setupNavLinks = ->
    $navLinks.on 'click', (e)->
      e.preventDefault()
      $this = $ this
      if ($this.attr('data-slide-index') && !swiper.animating)
        swiper.slideTo $this.attr('data-slide-index')
        $navLinks.removeClass 'active'
        $this.addClass 'active'

  setupSwiper = ->
    swiper = new Swiper '.swiper-container', {
      nextButton: '.swiper-button-next'
      prevButton: '.swiper-button-prev'
      hashnav: true
      onSlideChangeEnd : (swiperObject)->
        setActiveSlide(swiperObject.activeIndex)
    }
    setupNavLinks()

  return {
    init : setupSwiper
    swiper : swiper
  }
) window.Swiper, jQuery