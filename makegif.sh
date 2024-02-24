#! /bin/sh

outdir="$HOME/tmp"
 ffmpeg -i "$1" -vf "scale=iw/2:ih/2" "$outdir/$2".gif
