# Dotfiles

### Description

A collection of configurations for my systems

## Dependencies

- make
- zsh
- alacritty
- kitty
- tmux
- hyfetch
- tree
- stow
- npm (nvm recommended)
- neovim
  - if not using pacman, checkout [neovim's install instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux), because apt doesn't install latest version???
- neovim plugin deps: cmake, zip, unzip, curl, tar, gzip, ripgrep
- a [patched font](https://www.nerdfonts.com/), else icons won't render

## Setup - General

- clone repo to `$HOME/.dotfiles` (any immediate subdir of home will do)
- init submodules with `git submodule update --init --recursive`
- `./stow-dotfiles.sh` to stow files 
- zsh
  - add `ZDOTDIR=~/.config/zsh` to `/etc/zsh/zshenv` or `~/.zshenv`
  - `mkdir ~/.cache/zsh`
- tmux
  - attach a client and run `<prefix>I` to install plugins
- in neovim:
  - `:MasonInstall stylua prettier prettierd markdownlint`

## Setup - Windows

- install [wslu](https://wslutiliti.es/wslu/install.html)
- alacritty
  - ensure `~/.local/bin` is in your PATH
  - `alacopy2win.sh` to copy alacritty.toml to the required windows location
    - run this after each update to alacritty.toml
  - see `alacopy2win.sh -h` for more info

## GNOME stuff

- Extensions
  - get `gnome-browser-connector` package and 'GNOME Shell integration' browser extension
  - [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
  - [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
  - [Tiling Assistant](https://extensions.gnome.org/extension/3733/tiling-assistant/)
- Packages
    <!-- TODO -->
  - vlc
  - copyq
  - blueman
- Appearance
  - [Tela Circle Icons](https://github.com/vinceliuice/Tela-circle-icon-theme)

## TODO

- add icons to dotfiles
