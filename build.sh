#!/bin/bash

files=$(git log --pretty='' --name-only | awk '!seen[$0]++' | grep -E '.*(\.png|\.mp4|\.webp)$')
directories=$(ls -d */ | grep -v temp | grep -v public | grep -v node_modules)
baseUrl='https://media.marcdahmen.de'
template=$(<template.html)
public='./public'

mkdir -p public

homeLink() {
	cls=''

	if [ -z "$1" ]; then
		cls='class="active"'
	fi

	echo "<a href=\"./\" $cls>all</a>"
}

generateGallery() {
	page="${1%/}"
	nav="$(homeLink $1)"
	gallery=''
	filtered=$(echo "$files" | grep "$1")

	if [ -z "$page" ]; then
		page='index'
	fi

	for dir in $directories; do
		cls=''

		if [[ "$1" == "$dir" ]]; then
			cls='class="active"'
		fi

		read -r -d '' navItem <<-EOF
			<a href="./${dir%/}.html" $cls>
				 ${dir%/}
			</a>
		EOF

		nav="${nav}\n${navItem}"
	done

	templateWithNav="${template/__NAV__/$nav}"

	for file in $(echo $filtered); do
		url="$baseUrl/$file"
		element="<img src=\"${url}\" />"

		if [[ $file =~ \.mp4$ ]]; then
			element="<video playsinline autoplay muted><source src=\"${url}\" type=\"video/mp4\" /></video>"
		fi

		read -r -d '' item <<-EOF
			<a
				href="${url}" 
				class="card"
				title="${file}"
				target="_blank"
			>
				${element} 
			</a>
		EOF

		gallery="${gallery}\n${item}\n"
	done

	echo -e "${templateWithNav/__ITEMS__/$gallery}" >"$public/$page.html"
}

generateGallery

for dir in $directories; do
	generateGallery $dir
done
