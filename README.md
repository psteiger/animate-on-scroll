# animate-on-scroll
JQuery plugin for animating objects as they enter or leave the screen.

Examples:

        $('.fade-on-scroll').animateOnScroll({
          offset_top: 60,
          fade: true
        });

        $('.scale3d-on-scroll').animateOnScroll({
          scale3d:true
        });

All options and respective defaults:

        container: "window"
        event: "scroll"
        fade: true
        scale3d: false
        offset_top: 0
        offset_bottom: 0
