# colored output
alias ls="ls --color=auto"
alias tree="tree -C"
alias pacman="pacman --color auto"

# zdotdir
alias cdz="cd $ZDOTDIR"
alias srcz="clear && source $ZDOTDIR/.zshrc"

# git
alias gits="git status"
alias gitd="git diff"
alias gitds="git diff --staged"
alias gitg="git log --graph --all"
alias gitc="git commit -m"

# misc
alias l="ls -hAl"
alias clip="xclip -r -selection c"
alias nv="nvim"
alias apt_refresh="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean"

# WINDOWS ONLY start
alias cdw="cd /mnt/c/Users/$(wslvar USERNAME)/"
# WINDOWS ONLY end 

