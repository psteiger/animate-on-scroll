###!
* AnimateOnScroll
* github.com/psteiger/animate-on-scroll
###

animateOnScroll = ($) ->
  "use strict"

  pluginName = "animateOnScroll"
  _defaults =
    fade: {
      enable: true
      offset_top: 50
      offset_bottom: 50
      apply_css: (el, v) -> el.css 'opacity', v
    }
    scale3d: {
      enable: true
      apply_css: (el, v) -> el.css 'transform', 'scale3d(' + v + ',' + v + ',' + v + ')'
    }

  class AnimateOnScroll

    constructor: (@el, options) ->
      @options         = $.extend true, {}, _defaults, options
      @_defaults       = _defaults
      @_name           = pluginName
      @init()

    init: ->
      self      = @
      container = @options.container
      event     = @options.event

      $(window).scroll -> self.update()

      return self

    update: ->
      el = @el
      el_center = $(el).innerHeight() / 2
      offsets = [0,0] # top and bottom
      range = [0,1] # min and max value of transition

      if @elIsOnTop() || @elIsOnBottom()
        for animation, values of @options
          if values.enable
            if values.range?
              range = values.range
            if values.offset_top? && @elIsOnTop()
              offsets = [values.offset_top - el_center, values.offset_top + el_center]
            else if values.offset_bottom && @elIsOnBottom()
              offsets = [$(window).height() + el_center - values.offset_bottom, $(window).height() - el_center - values.offset_bottom]
            values.apply_css $(el), @computeTransformValue offsets, range

    # here happens the magic.
    #
    # the calculated transform value is a first-order function y = ax + b.
    # y axis represents the resulting transform value.
    # x axis represents the element vertical position on screen.
    # y_0, y_1 are the corresponding x values when y = 0, y = 1 respectively.
    # constants a, b where obtained by solving the system:
    # (1) range[1] = a*ys[1] + b
    # (2) range[0] = a*ys[0] + b
    # (3) b = range[0] - a*ys[0]     => (subs 4) => b = -ys[0] / (ys[1] * ys[0]);
    #     -a ys[0] = b - range[0]
    #     b = -a ys[0] + range[0] (subs 1)
    #     range[1] = a*ys[1] - a ys[0] + range[0]
    #     a*ys[1] - a*ys[0] = range[1] - range[0]
    #     a(ys[1] - ys[0]) = range[1] - range[0]
    # (4) a = (range[1] - range[0]) / (ys[1] - ys[0]);
    # (5) b = range[0] - ys[0]*(range[1] - range[0]) / (ys[1] - ys[0])

    computeTransformValue: (ys, range) ->
      a = (range[1] - range[0]) / (ys[1] - ys[0])
      x = @getCurrentElOffset().center
      b = range[0] - (ys[0]*(range[1] - range[0]) / (ys[1] - ys[0]))
      y = a * x + b

      Math.min (Math.max y, range[0]), range[1]

    getCurrentElOffset: ->
      bounds = $(@el).get(0).getBoundingClientRect()
      $.extend bounds, { center: (bounds.top + bounds.bottom) / 2 }

    elIsOnTop: ->
       @getCurrentElOffset().bottom >= 0 &&
       @getCurrentElOffset().center < $(window).height() / 2

    elIsOnBottom: ->
       @getCurrentElOffset().center >= $(window).height() / 2 &&
       @getCurrentElOffset().top <= $(window).height()

  # Plugin wrapper preventing against multiple instantiations.
  $.fn.animateOnScroll = (options) ->
      @each ->
        instance = $.data @, "plugin_" + pluginName
        if instance
          $.extend true, instance.options,  options
        else
          $.data @, "plugin_" + pluginName, new AnimateOnScroll @, options

  # Prevents CoffeeScript to return a value from plugin wrapper.
  return

# A factory that uses AMD, CommonJS or window globals to
# create the jQuery plugin.
do (plugin = animateOnScroll, window) ->
  hasDefine  = typeof define is "function" and define.amd?
  hasExports = typeof module isnt "undefined" and module.exports?

  # AMD.
  if hasDefine
    define ["jquery"], plugin

  # NodeJS/CommonJS.
  else if hasExports
    module.exports = plugin require "jquery"

  # Window globals.
  else
    plugin window.jQuery or window.$
