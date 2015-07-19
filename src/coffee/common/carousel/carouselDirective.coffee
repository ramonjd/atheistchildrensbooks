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
        speed: 750,
        #slidesToShow: 1,
        variableWidth: true,
        #autoplay: true,
        #autoplaySpeed: 2000,
        #centerMode: true,
        #variableWidth: true,
        #adaptiveHeight: true,
        focusOnSelect: true,
        infinite: true
      }
    }
]