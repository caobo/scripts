#/usr/bin/env dash

main() {
COMMIT=$(git log --pretty=format:"%h - %s (%ar)" -10 | \
    fzf --header-first --header="Choose a git commit" --preview 'git show --color=always $(echo {} | awk "{print \$1}")'| \
    awk '{print $1}')
if [ "$1" = "wd" ]; then
    git show --word-diff $COMMIT
    exit 0;
fi
    git show $COMMIT
}

main "$@"
