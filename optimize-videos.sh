#!/bin/bash

mkdir -p temp/optimized

for f in temp/*.mov; do
	echo "Processing $f ..."

	ffmpeg -i "$f" \
		-an \
		-vf "scale=1280:-1,setpts=PTS/2" \
		-c:v libx264 \
		-crf 25 \
		-preset slow \
		"temp/optimized/$(basename "${f%.mov}").mp4"
done
