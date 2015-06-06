'use strict'
angular.module('acb')
.directive 'fishSchool', [
  '$'
  'UtilsFactory'
  ($, UtilsFactory)->
    {
    restrict : 'A'
    replace : true
    template : '<div class="fish-school"><img src="/img/school-of-fish.png" alt="school of fish"></div>'
    link : (scope, element)->

      $element = $(element)
      $window = $(window)

      getWindowWidth =->
        $window.width() + 200 + 'px'

      animateLeft = ()->
        $element.velocity {
          p:
            right: getWindowWidth()
            scale: .75
            translateY: UtilsFactory.random 50, 200
          o:
            easing: 'linear'
            duration : 20000
            delay: 500
            complete:(element)->
              $element.velocity {
                rotateY: '180deg'
              }
              animateRight()
        }
      animateRight = ()->
        $element.velocity {
          p:
            right: '-200px'
            scale: .75
            translateY: -1 * UtilsFactory.random 50, 200
          o:
            easing: 'linear'
            duration : 20000
            delay: 500
            complete:->
              $element.velocity {
                rotateY: '0deg'
              }
              animateLeft()
        }
      animateLeft()
    }
]