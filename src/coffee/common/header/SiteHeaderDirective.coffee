'use strict'
angular.module('acb')
.directive 'siteHeader', [
  '$'
  '$timeout'
  ($, $timeout)->
    {
      restrict : 'A'
      templateUrl : 'templates/header.tpl.html'
      link : (scope, element, attrs)->

        $logoImgs = $ '.logo-wrapper > img'
        $sun = $ 'div.sun'
        $cloud = $ '.cloud'
        $clouds = $ '.bg-clouds'
        $balloon = $ '.questions-corner'

        unbindWatcher = scope.$watch('showSiteHeader', (showSiteHeaderValue) ->
          if showSiteHeaderValue is true
            showLogo()
            unbindWatcher()
          return
        )
        showLogo = ->
          $timeout ()->
            $logoImgs.toggleClass 'zoomInDown animated'
            $sun.toggleClass 'bounceIn animated'
            $timeout ()->
              $balloon.toggleClass 'lightSpeedIn animated'
            , 250
          , 750
          $timeout ()->
            $clouds.toggleClass 'bounceIn animated'
          , 250
          $cloud.toggleClass 'bounceIn animated'
          return
        return
    }
]