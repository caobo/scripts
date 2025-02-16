#/usr/bin/env dash

COMMIT=$(git log --pretty=format:"%h - %s (%ar)" -10 | fzf --header-first --header="Choose a git commit"| awk '{print $1}')

git show $COMMIT
