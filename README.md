# Dotfiles

### Description
A collection of configurations for my systems

## Prerequisites
- a c compiler
- make 
- zsh
- neofetch
- tree
- neovim
    * if not using pacman, checkout [neovim's install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux), because apt doesn't install latest version???
- ripgrep (telescope dep)
- a [patched font](https://www.nerdfonts.com/), else icons won't render

## Setup
- clone repo to `$HOME`
    * `cd $HOME`
    * `git init`
    * `git remote add origin git@github.com:soupsiedaisy/dotfiles.git`
    * `git pull origin main --allow-unrelated-histories`
    * `git branch -u origin/main main`
- init submodules with `git submodule update --init --recursive`
- add `ZDOTDIR=~/.config/zsh` to `/etc/zsh/zshenv` or `~/.zshenv` (create if doesn't exist)

## Windows config
- alacritty
    * ensure `~/.local/bin` is in your PATH
    * `alacopy2win.sh <username>` with your windows username
    * see `alacopy2win.sh -h` for more info

## TODO
- find a way to symlink %APPDATA%/alacritty/ to alacritty/
- separate windows config from unix config
- remove nvim.old after grabbing wanted config (in progress)
- create a global colors file
    * automation :3
- uhhh, refine this doc???

