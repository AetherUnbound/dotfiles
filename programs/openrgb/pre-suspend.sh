#!/bin/bash
# Write this to /usr/lib/systemd/system-sleep/pre-suspend.sh

if [ "${1}" == "pre" ]; then
	/usr/bin/openrgb --config /home/aether/.config/OpenRGB/ -p Off
elif [ "${1}" == "post" ]; then
	/usr/bin/openrgb --config /home/aether/.config/OpenRGB/ -p Static
     # Reload of GPU for ollama
     # https://github.com/ollama/ollama/blob/main/docs/gpu.mdx#linux-suspend-resume
     rmmod nvidia_uvm && modprobe nvidia_uvm
fi

