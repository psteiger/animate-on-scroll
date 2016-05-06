
###!
* AnimateOnScroll
* github.com/psteiger/animate-on-scroll
###

(($, window, document) ->

    AnimateOnScroll = (el, options) ->
        @el = el

        @options = $.extend({}, defaults, options)

        @_defaults = defaults
        @_name = pluginName
        @init()

    instances = []
    pluginName = "animateOnScroll"
    defaults =
        container: "window"
        event: "scroll"
        fade: true
        scale3d: false
        offset_top: 0
        offset_bottom: 0

    AnimateOnScroll:: =
        init: ->
          self = @
          container = @options.container
          event = @options.event

          if container == "window" && event == "scroll"
            $(window).scroll -> self.update()
          else
            $(container).on event, -> self.update()

          return self

        update: ->
          if @elIsOnTop()
            @animateOut()
          else if @elIsOnBottom()
            @animateIn()

        get_transform_value: (y_1, y_0) ->
          a           = 1 / (y_1 - y_0)
          x           = @get_el_center()
          b           = -y_0 / (y_1 - y_0)
          result      = a * x + b

          Math.min (Math.max result, 0), 1

        get_el_center: ->
          bounds = $(@el).get(0).getBoundingClientRect()

          return (bounds.top + bounds.bottom) / 2

        animate: (y_1, y_0) ->
          el = @el
          v = @get_transform_value(y_1, y_0)

          #if offset_top > $(window).height() / 2 || offset_bottom < $(window).height() / 2
          #  return

          if @options.fade
            $(el).css 'opacity', v

          if @options.scale3d
            $(el).css 'transform', 'scale3d(' + v + ',' + v + ',' + v + ')'

        animateIn: ->
          el_center = $(@el).innerHeight() / 2
          y_1 = $(window).height() - el_center - @options.offset_bottom
          y_0 = $(window).height() + el_center - @options.offset_bottom
          @animate y_1, y_0

        animateOut: ->
          el_center = $(@el).innerHeight() / 2
          y_1 = @options.offset_top + el_center
          y_0 = @options.offset_top - el_center
          @animate y_1, y_0

        elIsOnTop: ->
          rect = $(@el).get(0).getBoundingClientRect()
          rect.bottom >= 0 and rect.bottom < $(window).height() / 2

        elIsOnBottom:  ->
          rect = $(@el).get(0).getBoundingClientRect()
          rect.top > $(window).height() / 2 and rect.top <= $(window).height()

    # Plugin wrapper preventing against multiple instantiations.
    $.fn[pluginName] = (options) ->
        @each ->
          instance = $.data @, "plugin_" + pluginName

          if instance
            $.extend true, instance.options,  options
          else
            $.data @, "plugin_" + pluginName, new AnimateOnScroll(@, options)

    # Prevents CoffeeScript to return a value from plugin wrapper.
    return
) jQuery, window, document

