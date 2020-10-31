#!/bin/sh

node optimize.js
rsync -v temp/optimized/*.png automad/docs