#!/bin/bash

export PATH=$PATH:~/.local/bin/:~/.nvm/versions/node/v16.19.0/bin/

# get argument
file="$1"
# get the extension from the file name
ext=${file#*.}

case $ext in 
    md|js|mjs|ts)
        pnpm exec prettier -w "$file"
        ;;
    py)
        black "$file"
        ;;
    *)
        echo "Can't process file of type '$ext'!"
        exit 1
        ;;
esac
