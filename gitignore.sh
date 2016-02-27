#!/usr/bin/env bash

#####################################################
#													#
# 	Get a new .gitignore file with some sensible	#
# 	defaults from gitignore.io.						#
# 													#
# 	example:										#
# 	./gitignore.sh osx java eclipse	> .gitignore    #
# 													#
#####################################################

api_url="https://www.gitignore.io/api/"
allowed_types=$(curl -sS 'https://www.gitignore.io/dropdown/templates.json' -H 'pragma: no-cache' -H 'dnt: 1' -H 'accept-encoding: gzip, deflate, sdch' -H 'x-requested-with: XMLHttpRequest' -H 'accept-language: en-US,en;q=0.8' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36' -H 'accept: */*' -H 'cache-control: no-cache' -H 'authority: www.gitignore.io' -H 'cookie: __cfduid=de5bf2eaf956d4647fbc8409759e56db21455621496; connect.sid=s%3A0kcBEf42yR3goNMEu82KiyqilRqPmtih.8%2BICofnBe3QRnCZEJ7yoILIjS88NO5kb7i4TZaw8Jd0; __utmt=1; __utma=117241104.2141503911.1455622287.1456506752.1456588712.3; __utmb=117241104.2.10.1456588712; __utmc=117241104; __utmz=117241104.1455622287.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)' -H 'referer: https://www.gitignore.io/' --compressed)

# The api list, e.g. java,html,css
list=""

arg_count="$#"
counter=0

if [ "$#" == 0 ]; then
	echo "ERROR: use at least 1 argument"
	exit 1
fi

for arg in "$@"; do

	# Check the supplied argument is allowed
	ok=$(echo -n $allowed_types | grep $arg)

	if [ "$ok" == "" ]; then
		echo "$arg not found! exiting.."
		exit 1
	fi

	# Build the list, adding ',' to each
	list="$list$arg"
	let counter=counter+1
	if [ "$counter" -ne "$arg_count" ]; then
		list="$list,"
	fi
done

curl -sS "$api_url$list"