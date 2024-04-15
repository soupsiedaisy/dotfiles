#!/usr/bin/env zsh
# idk why it won't work with bash

for ((i = 0; i < 256; i++)); do
    print -Pn %F{$i}COLOUR $(printf %03d $i) %f
    if (( $((i % 4)) == 0 )); then
        print
    fi
done
print

