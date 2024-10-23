#!/bin/bash
# Write this to /usr/lib/systemd/system-sleep/pre-suspend.sh

if [ "${1}" == "pre" ]; then
	openrgb -p Off	
elif [ "${1}" == "post" ]; then
	openrgb -p Main
fi

