# animate-on-scroll

JQuery plugin for animating objects as they enter or leave the screen.

Animate-on-scroll is designed for simplicity, flexibility and extendibility

'fade' and 'scale3d' animations are currently supported, but you can
easily extend that to whatever CSS animations you like!

The only prerequisite for extending this plugin is that the function
must accept two parameters: the element, and the transform value.

See source code for more details.

## Install

### npm -- a JavaScript package manager

    npm install animate-on-scroll

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
        enable: true,
        range: [0,360],
        apply_css: (el, v) -> el.css 'transform', 'rotate(' + v + 'deg)'
      }
    });

Any function and range will do!

An item can have multiple classes and effects.

## Options

All supported options and respective defaults:

    fade: {
      enable: true,
      offset_top: 50,
      offset_bottom: 50,
      range: undefined,
      apply_css: (el, v) -> el.css 'opacity', v
    }
    scale3d: {
      enable: true,
      offset_top: undefined,
      offset_bottom: undefined,
      range: undefined,
      apply_css: (el, v) -> el.css 'transform', 'scale3d(' + v + ',' + v + ',' + v + ')'
    }

## Web resources

https://www.npmjs.com/package/animate-on-scroll

http://github.com/psteiger/animate-on-scroll

## Do you use this library?

Please contact me (mailto:psteiger@gmail.com) so we display your website here!

## Please donate!

This software's free and forever will be. If you like it, please consider donating any amount you like.

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=582TYZ3KV2JWW)
