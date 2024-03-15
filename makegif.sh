#! /bin/sh

outdir="$HOME/tmp"
ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos" -qscale:v 12 -c:v gif -f gif "$outdir/$2.gif"
