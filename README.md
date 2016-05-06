# animate-on-scroll

JQuery plugin for animating objects as they enter or leave the screen.

Animate-on-scroll is designed for simplicity.

'fade' and 'scale3d' animations are currently supported.

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

The following code makes all elements with class '.fade-on-scroll' to fade out
of the screen (with a top offset of 60).

    $('.fade-on-scroll').animateOnScroll({
      offset_top: 60,
      fade: true
    });

If we want to scale items with class 'scale3d-on-scroll':

    $('.scale3d-on-scroll').animateOnScroll({
      scale3d:true
    });

An item can have multiple classes and effects.

## Options

All options and respective defaults:

    container: "window"
    event: "scroll"
    fade: true
    scale3d: false
    offset_top: 0
    offset_bottom: 0

## Web resources

https://www.npmjs.com/package/animate-on-scroll

http://github.com/psteiger/animate-on-scroll
