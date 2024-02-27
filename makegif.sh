#! /bin/sh

outdir="$HOME/tmp"
ffmpeg -i "$1" -vf "fps=15,scale=320:-1:flags=lanczos" -c:v gif -f gif "$outdir/$2.gif"
