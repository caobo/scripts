#!/usr/bin/env dash

main() {
local COMMIT=$(git log --pretty=format:"%h - %s (%ar)" -10 | \
    fzf --header-first --header="Choose a git commit" --preview 'git show --stat --color=always $(echo {} | awk "{print \$1}")'| \
    awk '{print $1}')

if [ -z "$COMMIT" ]; then
    echo "Please select a git commit."
    exit 0
fi

if [ "$1" = "wd" ]; then
    git show --word-diff $COMMIT
    exit 0;
fi
    git show $COMMIT
}

main "$@"
