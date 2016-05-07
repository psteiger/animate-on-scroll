# animate-on-scroll

JQuery plugin for animating objects as they enter or leave the screen.

Animate-on-scroll is designed for simplicity, flexibility and extendibility

'fade' and 'scale3d' animations are currently supported by default, but you can
easily extend that!

## See for yourself

http://www.bitbahia.com.br/

## Install

### npm -- a JavaScript package manager

    npm install animate-on-scroll

### Ruby on Rails Gem

(Warning! Not implemented yet.)

Setup your Gemfile:

    gem 'animate-on-scroll'

Install it:

    bundle

## Use examples

The simplest use:

    $('.fade-on-scroll').animateOnScroll();

This enables fade effect and scale3d effect by default.

If you're unhappy with the defaults, you can customize the options. Suppose we
don't want scale3d:

    $('.fade-on-scroll').animateOnScroll({
      scale3d: false
    });

The following code makes all elements with class '.fade-on-scroll' fade out
of the screen with a top offset of 120 and a bottom offset of 60.

Also, disables the scale3d effect.

    $('.fade-on-scroll').animateOnScroll({
      fade: {
        offset_top: 120,
        offset_bottom: 60
      },
      scale3d: {
        enable: false
      }
    });

If we want to scale only the items with class 'scale3d-on-scroll':

    $('.scale3d-on-scroll').animateOnScroll({
      scale3d: {
        enable: true,
        offset_top: 40,
        offset_bottom: -30
      }
    });

If we want to rotate some objects as they enter and leave the screen, we can
supply our own special range and rotate function:

    $('.rotate-on-scroll').animateOnScroll({
      rotate: {
        enable: true
        range: [0,360]
        apply_css: (el, v) -> el.css 'transform', 'rotate(' + v + 'deg)'
      }
    });

Any function and range will do!

An item can have multiple classes and effects.

## Options

All supported options and respective defaults:

    fade: {
      enable: true
      offset_top: 50
      offset_bottom: 50
      range: undefined
      apply_css: (el, v) -> el.css 'opacity', v
    }
    scale3d: {
      enable: true
      offset_top: undefined
      offset_bottom: undefined
      range: undefined
      apply_css: (el, v) -> el.css 'transform', 'scale3d(' + v + ',' + v + ',' + v + ')'
    }

## Web resources

https://www.npmjs.com/package/animate-on-scroll

http://github.com/psteiger/animate-on-scroll
