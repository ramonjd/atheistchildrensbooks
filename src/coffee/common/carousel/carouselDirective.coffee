'use strict'
angular.module('acb')
.directive 'carousel', [
  '$'
  ($)->
    {
    restrict : 'E'
    templateUrl : 'templates/carousel.tpl.html'
    link : (scope, element, attrs)->
      $('.carousel').slick {
        dots: true,
        speed: 300,
        slidesToShow: 3,
        slidesToScroll: 1,
        #autoplay: true,
        #autoplaySpeed: 2000,
        centerMode: true,
        adaptiveHeight: true,
        focusOnSelect: true,
        responsive: [
          {
            breakpoint: 768,
            settings: {
              slidesToShow: 1,
              slidesToScroll: 1
            }
          }
        ]
      }
    }
]