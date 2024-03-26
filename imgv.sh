#!/bin/sh

DIR="$(pwd)"

viewimage(){
    qlmanage -p $(fd ".*" "$DIR" -t f -x file --mime-type | awk -F ":" '/.*:.*image/ {print $1}')
}

viewimage &>/dev/null &
