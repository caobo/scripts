#! /bin/sh

[ -d "$1" ] && du -sh "$1" | awk '{print "folder size is: " $1}' || du -sh "$1" | awk '{print "file size is: " $1}'
