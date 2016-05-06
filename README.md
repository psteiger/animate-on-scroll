# animate-on-scroll

JQuery plugin for animating objects as they enter or leave the screen.

Animate-on-scroll is designed for simplicity.

'fade' and 'scale3d' animations are currently supported.

## Install

    $ npm install --save animate-on-scroll


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

## See for yourself

http://www.bitbahia.com.br/
