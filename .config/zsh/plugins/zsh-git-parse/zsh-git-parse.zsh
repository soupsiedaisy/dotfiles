# declare ZGP vars
declare -x ZGP_IS_GIT
declare -x ZGP_BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
declare -ix ZGP_STATUS_UNTRACKED=0
declare -ix ZGP_STATUS_STAGED=0
declare -ix ZGP_STATUS_UNSTAGED=0
declare -x ZGP_BRANCH_HAS_UPSTREAM
declare -x ZGP_STATUS_BRANCH_UP_TO_DATE
declare -ix ZGP_STATUS_BRANCH_AHEAD=0
declare -ix ZGP_STATUS_BRANCH_BEHIND=0

declare -x ZGP_STAGED_SYM='+'
declare -x ZGP_UNSTAGED_SYM='!'
declare -x ZGP_UNTRACKED_SYM='?'
declare -x ZGP_BRANCH_NO_UPSTREAM_SYM='×'
declare -x ZGP_BRANCH_UP_TO_DATE_SYM='≡'
declare -x ZGP_BRANCH_AHEAD_SYM='↑'
declare -x ZGP_BRANCH_BEHIND_SYM='↓'

# functions (should this be above the declarations?)
handle_status_branch() {
  local STATUS=$(echo "$*" | grep -Eo '[[](ahead|behind)[[:space:]][[:digit:]](,[[:space:]](ahead|behind)[[:space:]][[:digit:]])?[]]$' 2> /dev/null)
  if [[ -z $STATUS ]]; then
    return
  fi

  STATUS=${STATUS:1:-1}
  STATUS=${STATUS/,}

  IFS=' ' read -rA BRANCH_STATUSES <<<"$STATUS"

  # why 1 based indexing @zsh??
  for ((i = 1; i < ${#BRANCH_STATUSES[@]} + 1; i++)); do
    if [[ ${BRANCH_STATUSES[i]} == "ahead" ]]; then
      ZGP_STATUS_BRANCH_AHEAD=${BRANCH_STATUSES[i+1]}
    elif [[ ${BRANCH_STATUSES[i]} == "behind" ]]; then
      ZGP_STATUS_BRANCH_BEHIND=${BRANCH_STATUSES[i+1]}
    fi
  done
}

git rev-parse --is-inside-work-tree &> /dev/null
if [[ $? -eq 0 ]]; then
  ZGP_IS_GIT=true
else
  ZGP_IS_GIT=false
fi

git rev-parse --abbrev-ref $ZGP_BRANCH@{upstream} &> /dev/null
if [[ $? -eq 0 ]]; then
  ZGP_BRANCH_HAS_UPSTREAM=true
else
  ZGP_BRANCH_HAS_UPSTREAM=false
fi

# parse porcelain status into STATUSES array
declare STATUS_RAW=$(git status --porcelain -b 2> /dev/null)
IFS=$'\n' read -rd '' -A STATUSES <<<"$STATUS_RAW"
unset STATUS_RAW

# calculate ZGP_STATUS_* values 
for STATUS in "${STATUSES[@]}";
do
  local CODE=$(echo $STATUS | cut -c 1-2)
  if [[ $ZGP_BRANCH_HAS_UPSTREAM == true && $CODE =~ ^##$ ]]; then
    handle_status_branch $STATUS
  fi
  if [[ $CODE =~ ^[[:space:]].$ ]]; then
    ZGP_STATUS_UNSTAGED+=1 # TODO add handle_unstaged function 
  fi
  if [[ $CODE =~ ^.[[:space:]]$ ]]; then
    ZGP_STATUS_STAGED+=1 # TODO add handle_staged function 
  fi
  if [[ $CODE =~ ^[?][?]$ ]]; then
    ZGP_STATUS_UNTRACKED+=1 # TODO add handle_untracked function 
  fi
done
unset STATUSES

# set up-to-date var
if [[ $ZGP_BRANCH_HAS_UPSTREAM == true && $ZGP_STATUS_BRANCH_AHEAD -eq 0 && $ZGP_STATUS_BRANCH_BEHIND -eq 0 ]]; then
  ZGP_STATUS_BRANCH_UP_TO_DATE=true
else
  ZGP_STATUS_BRANCH_UP_TO_DATE=false
fi

autoload -Uz add-zsh-hook

gen_git_prompt () {
  [[ -f $ZDOTDIR/plugins/zsh-git-parse/zsh-git-parse.plugin.zsh ]] && source $ZDOTDIR/plugins/zsh-git-parse/zsh-git-parse.plugin.zsh > /dev/null 2> /dev/null

  if [[ "$ZGP_IS_GIT" == false ]]; then
    ZGP_PROMPT=''
    return
  fi

  # Branch segment
  ZGP_PROMPT="on $ZGP_BRANCH"

  if [[ $ZGP_BRANCH_HAS_UPSTREAM == false ]]; then
    ZGP_PROMPT+=" $ZGP_BRANCH_NO_UPSTREAM_SYM"
  elif [[ $ZGP_STATUS_BRANCH_UP_TO_DATE == true ]]; then
    ZGP_PROMPT+=" $ZGP_BRANCH_UP_TO_DATE_SYM"
  else
    if [[ $ZGP_STATUS_BRANCH_AHEAD -gt 0 ]]; then
      ZGP_PROMPT+=" $ZGP_BRANCH_AHEAD_SYM$ZGP_STATUS_BRANCH_AHEAD"
    fi
    if [[ $ZGP_STATUS_BRANCH_BEHIND -gt 0 ]]; then
      ZGP_PROMPT+=" $ZGP_BRANCH_BEHIND_SYM$ZGP_STATUS_BRANCH_BEHIND"
    fi
  fi

  # Staged and unstaged segment
  if [[ $ZGP_STATUS_STAGED -ne 0 || $ZGP_STATUS_UNSTAGED -ne 0 || $ZGP_STATUS_UNTRACKED -ne 0 ]]; then
    ZGP_PROMPT+=" |"
    if [[ $ZGP_STATUS_STAGED -ne 0 ]]; then
      ZGP_PROMPT+=" $ZGP_STATUS_STAGED$ZGP_STAGED_SYM"
    fi
    if [[ $ZGP_STATUS_UNSTAGED -ne 0 ]]; then
      ZGP_PROMPT+=" $ZGP_STATUS_UNSTAGED$ZGP_UNSTAGED_SYM"
    fi
    if [[ $ZGP_STATUS_UNTRACKED -ne 0 ]]; then
      ZGP_PROMPT+=" $ZGP_STATUS_UNTRACKED$ZGP_UNTRACKED_SYM"
    fi
  fi
}

add-zsh-hook precmd gen_git_prompt

setopt prompt_subst

# TODO unset vars in zsh closing function thing
# unset ZGP_IS_GIT
# unset ZGP_BRANCH
# unset ZGP_STATUS_UNTRACKED
# unset ZGP_STATUS_STAGED
# unset ZGP_STATUS_UNSTAGED

# TODO
# manage the vars export 
  # get inspo from omz

