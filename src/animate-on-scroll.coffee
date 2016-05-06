###!
* AnimateOnScroll
* github.com/psteiger/animate-on-scroll
###

animateOnScroll = ($) ->
  "use strict"

  pluginName = "animateOnScroll"
  _defaults =
    container: "window"
    event: "scroll"
    fade: true
    scale3d: false
    offset_top: 0
    offset_bottom: 0

  class AnimateOnScroll

    constructor: (@el, options) ->
      el_center        = $(@el).innerHeight() / 2
      @options         = $.extend {}, _defaults, options
      @top_offsets     = [@options.offset_top - el_center                        , @options.offset_top + el_center]
      @bottom_offsets  = [$(window).height() + el_center - @options.offset_bottom, $(window).height() - el_center - @options.offset_bottom]
      @_defaults       = _defaults
      @_name           = pluginName
      @init()

    init: ->
      self      = @
      container = @options.container
      event     = @options.event

      if container == "window" && event == "scroll"
        $(window).scroll -> self.update()
      else
        $(container).on event, -> self.update()

      return self

    update: ->
      el = @el

      if @elIsOnTop() || @elIsOnBottom()
        v = @computeTransformValue()

      if v?   # computed value is undefined if el not in relevant offset
        if @options.fade
          $(el).css 'opacity', v
        if @options.scale3d
          $(el).css 'transform', 'scale3d(' + v + ',' + v + ',' + v + ')'

    # here happens the magic.
    #
    # the calculated transform value is a first-order function y = ax + b.
    # y axis represents the resulting transform value.
    # x axis represents the element vertical position on screen.
    # y_0, y_1 are the corresponding x values when y = 0, y = 1 respectively.
    # constants a, b where obtained by solving the system:
    # (1) 1 = a*y_1 + b
    # (2) 0 = a*y_0 + b
    # (3) b = -a*y_0 => (subs 4) => b = -y_0 / (y_1 * y_0);
    #      y_0 = -b/a (subs 1)
    #      a*y_1 - a*y_0 = 1
    #      a(FADE BEGIN - y_0) = 1
    # (4) a = 1/(y_1 - y_0);

    computeTransformValue: ->
      if @elIsOnTop()
        [y_0, y_1] = @top_offsets
      else if @elIsOnBottom()
        [y_0, y_1] = @bottom_offsets
      else # is not on screen
        undefined

      a = 1 / (y_1 - y_0)
      x = @getCurrentElOffset().center
      b = -y_0 / (y_1 - y_0)
      y = a * x + b

      Math.min (Math.max y, 0), 1

    getCurrentElOffset: ->
      bounds = $(@el).get(0).getBoundingClientRect()
      $.extend bounds, { center: (bounds.top + bounds.bottom) / 2 }

    elIsOnTop: ->
       0                      <= @getCurrentElOffset().bottom < $(window).height() / 2

    elIsOnBottom: ->
       $(window).height() / 2 <= @getCurrentElOffset().top    <= $(window).height()

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
