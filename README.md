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

Coming soon:

    gem 'animate-on-scroll', :git => 'git://github.com/psteiger/animate-on-scroll.git'

## Examples

    $('.fade-on-scroll').animateOnScroll({
      offset_top: 60,
      fade: true
    });

    $('.scale3d-on-scroll').animateOnScroll({
      scale3d:true
    });

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
