#!/bin/bash

files=$(git log --pretty='' --name-only | awk '!seen[$0]++' | grep -E '.*(\.png|\.mp4|\.webp)$')
baseUrl="https://raw.githubusercontent.com/marcantondahmen/media-files/master"
output="public/index.html"

mkdir -p public

gallery=''

for file in $(echo $files); do
	url="$baseUrl/$file"
	element="<img src=\"${url}\" />"

	if [[ $file =~ \.mp4$ ]]; then
		element="<video playsinline autoplay muted><source src=\"${url}\" type=\"video/mp4\" /></video>"
	fi

	read -r -d '' item <<-EOF
		<a
			href="${url}" 
			title="${file}"
			target="_blank"
		>
			${element} 
		</a>
	EOF

	gallery="${gallery}\n${item}\n"
done

html=$(<template.html)

echo -e "${html/__ITEMS__/$gallery}" >$output
