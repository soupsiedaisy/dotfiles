#!/usr/bin/env bash

version=1.0
help=(
    "ALACOPY2WIN - copies alacritty config to necessary Windows location from within a wsl instance. Uses wslu to get the windows USERNAME env var."
    ""
    "Usage: alacopy2win [options]           copy ~/.config/alacritty/alacritty.toml to /mnt/c/Users/<USERNAME>/AppData/Roaming/alacritty/alacritty.toml"
    ""
    "Options:"
    "   -h or --help                        print this help"
    "   -V or --version                     print version number (like I'm ever gonna change that lol)"
    "   -d or --target-directory <dir>      where to find the target alacritty.toml file. default is ~/.config/alacritty"
    ""
    "Examples:"
    "   'alacopy2win'                       copy ~/.config/alacritty/alacritty.toml to /mnt/c/Users/<USERNAME>/AppData/Roaming/alacritty/alacritty.toml"
    "   'alacopy2win -d path/to/alacritty'  copy path/to/alacritty/alacritty.toml to /mnt/c/Users/<USERNAME>/AppData/Roaming/alacritty/alacritty.toml"
)

target_directory="$HOME/.config/alacritty"
dest_directory="/mnt/c/Users/$(wslvar USERNAME)/AppData/Roaming"

err_and_exit() {
    echo Error: $*
    echo run with -h option for help
    exit 1
}

create_dest_dir() {
    if [[ ! -d $dest_directory ]]; then
        err_and_exit $dest_directory does not exist
    fi
    dest_directory=$dest_directory/alacritty
    mkdir -p $dest_directory
}

while [[ $1 =~ ^- && ! $1 == '--' ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -h | --help )
    printf '%s\n' "${help[@]}"
    exit
    ;;
  -d | --target-directory )
    
    shift; target_directory=${1/%"/"}
    ;;
esac; shift; done
if [[ $1 == '--' ]]; then shift; fi

if [[ ! -e $target_directory/alacritty.toml ]]; then
    err_and_exit could not find $target_directory/alacritty.toml
fi

create_dest_dir 

cp $target_directory/alacritty.toml $dest_directory/alacritty.toml

