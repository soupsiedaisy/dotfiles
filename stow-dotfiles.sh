#!/usr/bin/env bash

STOW_DIRS=$(cat .stow-directories)
ARGS=$*

check-no-folding () {
    if [[ -f $1/.stow-no-folding ]]; then
        NO_FOLD="--no-folding"
    else
        unset NO_FOLD
    fi
}

if [[ -z $ARGS ]]; then
    ARGS='-R'
fi

for dir in $(echo $STOW_DIRS | sed "s/,/ /g"); do
    check-no-folding $dir
    echo "running 'stow $ARGS $NO_FOLD $dir'"
    stow $* $dir
done

