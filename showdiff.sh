#/usr/bin/env dash

COMMIT=$(git log --pretty=format:"%h - %s (%ar)" -10 | fzf --height=50% \
  --layout=reverse \
  --border=rounded \
  --info=inline \
  --prompt='>_ ' \
  --pointer='➜ ' \
  --marker='✔' | awk '{print $1}')

git show $COMMIT
