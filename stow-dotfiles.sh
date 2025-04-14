#!/usr/bin/env bash

STOW_DIRS=$(cat .stow-directories)

for dir in $(echo $STOW_DIRS | sed "s/,/ /g")
do
    echo "stowing $dir"
    stow -R $dir
done


