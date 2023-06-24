#!/bin/sh

# Use xplr to open a file or directory in the default app
TARGET=$(xplr $1)
[ -z "$TARGET" ] || ( $(file -b $TARGET | rg -q 'text|empty') && nvim $TARGET ||
    ( [ "$(uname)" = "Darwin" ] && open "$TARGET" ) )
