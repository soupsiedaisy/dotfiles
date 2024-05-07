# Dotfiles

### Description
A collection of configurations for my systems

## Requirements
- make 
- zsh
- neofetch
- tree
- neovim
    * if not using pacman, checkout [neovim's install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux), because apt doesn't install latest version???
- neovim plugin deps: cmake, zip, unzip, curl, tar, gzip, ripgrep 
- a [patched font](https://www.nerdfonts.com/), else icons won't render

## Setup - General
- clone repo to `$HOME`
    * `cd $HOME`
    * `git init`
    * `git remote add origin git@github.com:soupsiedaisy/dotfiles.git`
    * `git pull origin main --allow-unrelated-histories`
    * `git branch -u origin/main main`
- init submodules with `git submodule update --init --recursive`
- add `ZDOTDIR=~/.config/zsh` to `/etc/zsh/zshenv` or `~/.zshenv` (create if doesn't exist)
- in neovim:
    * `:Mason install stylua prettier prettierd`

## Setup - Windows
- install [wslu](https://wslutiliti.es/wslu/install.html)
- alacritty
    * ensure `~/.local/bin` is in your PATH
    * `alacopy2win.sh` to copy alacritty.toml to the required windows location
        * run this after each update to alacritty.toml
    * see `alacopy2win.sh -h` for more info

## TODO
- create a global colors file
    * automation :3

