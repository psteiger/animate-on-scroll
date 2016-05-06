// Generated by CoffeeScript 1.10.0

/*!
* AnimateOnScroll
* github.com/psteiger/animate-on-scroll
 */

(function() {
  (function($, window, document) {
    var AnimateOnScroll, defaults, instances, pluginName;
    AnimateOnScroll = function(el, options) {
      this.el = el;
      this.options = $.extend({}, defaults, options);
      this._defaults = defaults;
      this._name = pluginName;
      return this.init();
    };
    instances = [];
    pluginName = "animateOnScroll";
    defaults = {
      container: "window",
      event: "scroll",
      fade: true,
      scale3d: false,
      offset_top: 0,
      offset_bottom: 0
    };
    AnimateOnScroll.prototype = {
      init: function() {
        var container, event, self;
        self = this;
        container = this.options.container;
        event = this.options.event;
        if (container === "window" && event === "scroll") {
          $(window).scroll(function() {
            return self.update();
          });
        } else {
          $(container).on(event, function() {
            return self.update();
          });
        }
        return self;
      },
      update: function() {
        if (this.elIsOnTop()) {
          return this.animateOut();
        } else if (this.elIsOnBottom()) {
          return this.animateIn();
        }
      },
      get_transform_value: function(y_1, y_0) {
        var a, b, result, x;
        a = 1 / (y_1 - y_0);
        x = this.get_el_center();
        b = -y_0 / (y_1 - y_0);
        result = a * x + b;
        return Math.min(Math.max(result, 0), 1);
      },
      get_el_center: function() {
        var bounds;
        bounds = $(this.el).get(0).getBoundingClientRect();
        return (bounds.top + bounds.bottom) / 2;
      },
      animate: function(y_1, y_0) {
        var el, v;
        el = this.el;
        v = this.get_transform_value(y_1, y_0);
        if (this.options.fade) {
          $(el).css('opacity', v);
        }
        if (this.options.scale3d) {
          return $(el).css('transform', 'scale3d(' + v + ',' + v + ',' + v + ')');
        }
      },
      animateIn: function() {
        var el_center, y_0, y_1;
        el_center = $(this.el).innerHeight() / 2;
        y_1 = $(window).height() - el_center - this.options.offset_bottom;
        y_0 = $(window).height() + el_center - this.options.offset_bottom;
        return this.animate(y_1, y_0);
      },
      animateOut: function() {
        var el_center, y_0, y_1;
        el_center = $(this.el).innerHeight() / 2;
        y_1 = this.options.offset_top + el_center;
        y_0 = this.options.offset_top - el_center;
        return this.animate(y_1, y_0);
      },
      elIsOnTop: function() {
        var rect;
        rect = $(this.el).get(0).getBoundingClientRect();
        return rect.bottom >= 0 && rect.bottom < $(window).height() / 2;
      },
      elIsOnBottom: function() {
        var rect;
        rect = $(this.el).get(0).getBoundingClientRect();
        return rect.top > $(window).height() / 2 && rect.top <= $(window).height();
      }
    };
    $.fn[pluginName] = function(options) {
      return this.each(function() {
        var instance;
        instance = $.data(this, "plugin_" + pluginName);
        if (instance) {
          return $.extend(true, instance.options, options);
        } else {
          return $.data(this, "plugin_" + pluginName, new AnimateOnScroll(this, options));
        }
      });
    };
  })(jQuery, window, document);

}).call(this);