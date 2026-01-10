# =================================
# Sources 
# =================================

[[ -f $ZDOTDIR/zsh_exports.zsh ]] && source $ZDOTDIR/zsh_exports.zsh
[[ -f $ZDOTDIR/zsh_aliases.zsh ]] && source $ZDOTDIR/zsh_aliases.zsh
[[ -f $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]] && source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
[[ -f $ZDOTDIR/plugins/zsh-git-parse/zsh-git-parse.plugin.zsh ]] && source $ZDOTDIR/plugins/zsh-git-parse/zsh-git-parse.plugin.zsh > /dev/null 2> /dev/null
[[ -f $ZDOTDIR/plugins/zsh-moon-phase/zsh-moon-phase.plugin.zsh ]] && source $ZDOTDIR/plugins/zsh-moon-phase/zsh-moon-phase.plugin.zsh

# =================================
# Keymaps
# =================================

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"           beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"            end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"         overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"      backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"         delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"             up-line-or-history
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"           down-line-or-history
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"           backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"          forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"         beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"       end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"      reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"   backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}"  forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# =================================
# ZVM
# =================================

# Put zvm config here

# =================================
# Prompt 
# =================================

# Constants
COLOUR_OK='white'
COLOUR_FAIL='red'
COLOUR_DULL='008'
COLOUR_PATH='blue'
LEADING_SYM=$(echo -e $ZMP_PHASE_SYM)

# Prompt Definitions
PROMPT_USER_HOST="%F{$COLOUR_DULL}%n@%m%f"
PROMPT_PATH="%F{$COLOUR_PATH}%~%f"
PROMPT_LEADER="%(?.%F{$COLOUR_OK}$LEADING_SYM%f.%F{$COLOUR_FAIL}$LEADING_SYM%f)"

PS1="$PROMPT_USER_HOST $PROMPT_PATH $PROMPT_LEADER "
RPS1='%F{$COLOUR_DULL}$ZGP_PROMPT%f' # This needs to be single quotes so that the parameters are expanded on each render

# =================================
# Misc config
# =================================

test -r .dircolors && eval "$(dircolors .dircolors)"

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
unsetopt MENU_COMPLETE 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # hidden files

# history size and location
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
zvm_bindkey vicmd "k" up-line-or-beginning-search
zvm_bindkey vicmd "j" down-line-or-beginning-search

# hyfetch on zsh open
hyfetch

# remove beeps (unreliant)
unsetopt BEEP

# remove hightlight on pastes
zle_highlight=('paste:none')

# This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Kitty integration
if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

# syntax highlighting: needs to be last
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =================================
# Cursors
# =================================

# \e[0 q or \e[ q: reset to what's defined in profile
# \e[1 q: blinking block
# \e[2 q: steady block
# \e[3 q: blinking underline
# \e[4 q: steady underline
# \e[5 q: blinking I-beam
# \e[6 q: steady I-beam

