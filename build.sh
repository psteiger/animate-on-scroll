#!/bin/bash
coffee --compile --output assets/javascript/
git add .
git commit -a -m "$1"
npm version patch
npm publish
