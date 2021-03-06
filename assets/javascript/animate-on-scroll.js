// Generated by CoffeeScript 1.10.0

/*!
* AnimateOnScroll
* github.com/psteiger/animate-on-scroll
 */

(function() {
  var animateOnScroll;

  animateOnScroll = function($) {
    "use strict";
    var AnimateOnScroll, _defaults, pluginName;
    pluginName = "animateOnScroll";
    _defaults = {
      fade: {
        enable: true,
        offset_top: 50,
        offset_bottom: 50,
        apply_css: function(el, v) {
          return el.css('opacity', v);
        }
      },
      scale3d: {
        enable: true,
        apply_css: function(el, v) {
          return el.css('transform', 'scale3d(' + v + ',' + v + ',' + v + ')');
        }
      }
    };
    AnimateOnScroll = (function() {
      function AnimateOnScroll(el1, options) {
        this.el = el1;
        this.options = $.extend(true, {}, _defaults, options);
        this._defaults = _defaults;
        this._name = pluginName;
        this.init();
      }

      AnimateOnScroll.prototype.init = function() {
        var container, event, self;
        self = this;
        container = this.options.container;
        event = this.options.event;
        $(window).scroll(function() {
          return self.update();
        });
        return self;
      };

      AnimateOnScroll.prototype.update = function() {
        var animation, el, el_center, offsets, range, ref, results, values;
        el = this.el;
        el_center = $(el).innerHeight() / 2;
        offsets = [0, 0];
        range = [0, 1];
        if (this.elIsOnTop() || this.elIsOnBottom()) {
          ref = this.options;
          results = [];
          for (animation in ref) {
            values = ref[animation];
            if (values.enable) {
              if (values.range != null) {
                range = values.range;
              }
              if ((values.offset_top != null) && this.elIsOnTop()) {
                offsets = [values.offset_top - el_center, values.offset_top + el_center];
              } else if (values.offset_bottom && this.elIsOnBottom()) {
                offsets = [$(window).height() + el_center - values.offset_bottom, $(window).height() - el_center - values.offset_bottom];
              }
              results.push(values.apply_css($(el), this.computeTransformValue(offsets, range)));
            } else {
              results.push(void 0);
            }
          }
          return results;
        }
      };

      AnimateOnScroll.prototype.computeTransformValue = function(ys, range) {
        var a, b, x, y;
        a = (range[1] - range[0]) / (ys[1] - ys[0]);
        x = this.getCurrentElOffset().center;
        b = range[0] - (ys[0] * (range[1] - range[0]) / (ys[1] - ys[0]));
        y = a * x + b;
        return Math.min(Math.max(y, range[0]), range[1]);
      };

      AnimateOnScroll.prototype.getCurrentElOffset = function() {
        var bounds;
        bounds = $(this.el).get(0).getBoundingClientRect();
        return $.extend(bounds, {
          center: (bounds.top + bounds.bottom) / 2
        });
      };

      AnimateOnScroll.prototype.elIsOnTop = function() {
        return this.getCurrentElOffset().bottom >= 0 && this.getCurrentElOffset().center < $(window).height() / 2;
      };

      AnimateOnScroll.prototype.elIsOnBottom = function() {
        return this.getCurrentElOffset().center >= $(window).height() / 2 && this.getCurrentElOffset().top <= $(window).height();
      };

      return AnimateOnScroll;

    })();
    $.fn.animateOnScroll = function(options) {
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
  };

  (function(plugin, window) {
    var hasDefine, hasExports;
    hasDefine = typeof define === "function" && (define.amd != null);
    hasExports = typeof module !== "undefined" && (module.exports != null);
    if (hasDefine) {
      return define(["jquery"], plugin);
    } else if (hasExports) {
      return module.exports = plugin(require("jquery"));
    } else {
      return plugin(window.jQuery || window.$);
    }
  })(animateOnScroll, window);

}).call(this);
