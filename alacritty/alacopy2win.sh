#!/usr/bin/env bash

version=1.0
help="ALACOPY2WIN - copies alacritty config to necessary Windows location from within a wsl instance

Usage: alacopy2win [options] username       copy ./alacritty.toml to /mnt/c/Users/[username]/AppData/Roaming/alacritty/alacritty.toml

Options:
    -d or --target-directory <dir>        where to find the target alacritty.toml file (default .)

Examples:
    'alacopy2win foo'                           copy ./alacritty.toml to /mnt/c/Users/foo/AppData/Roaming/alacritty/alacritty.toml
    'alacopy2win -d path/to/alacritty foo'      copy path/to/alacritty/alacritty.toml to /mnt/c/Users/foo/AppData/Roaming/alacritty/alacritty.toml
"

target_directory="."
dest_directory="/mnt/c/Users/<username>/AppData/Roaming"

err_and_exit() {
    echo Error: $*
    echo run with -h option for help
    exit 1
}

create_dest_dir() {
    dest_directory=${dest_directory/<username>/$1}
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
    echo $help
    exit
    ;;
  -d | --target-directory )
    
    shift; target_directory=${1/%"/"}
    ;;
esac; shift; done
if [[ $1 == '--' ]]; then shift; fi

if [[ -z $1 ]]; then
    err_and_exit username was not provided
fi

username=$1

if [[ ! -e $target_directory/alacritty.toml ]]; then
    err_and_exit could not find $target_directory/alacritty.toml
fi

create_dest_dir $username

cp $target_directory/alacritty.toml $dest_directory/alacritty.toml

