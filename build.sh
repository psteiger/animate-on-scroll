#!/bin/bash
coffee --compile --output assets/javascript/ src/animate-on-scroll.coffee
git add .
git commit -a -m "$1"
npm version patch
npm publish
git push
