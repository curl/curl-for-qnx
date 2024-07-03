#!/bin/sh
for a in _build/curl-*; do
    if test -n "$arg"; then
        arg=$(echo "&& $arg")
    fi
    arg=$(echo "gpg -b -a $a $arg")
done
echo "Run this to sign them:"
echo "$arg"

