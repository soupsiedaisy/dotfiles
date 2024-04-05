# MY FIRST ATTEMPT AT A PLUGIN LMAO BE GENTLE

# declare ZGP vars
declare -x ZGP_IS_GIT
declare -x ZGP_BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
declare -ix ZGP_STATUS_UNTRACKED=0
declare -ix ZGP_STATUS_STAGED=0
declare -ix ZGP_STATUS_UNSTAGED=0
declare -x ZGP_STATUS_BRANCH_UP_TO_DATE
declare -ix ZGP_STATUS_BRANCH_AHEAD=0
declare -ix ZGP_STATUS_BRANCH_BEHIND=0

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

# assign ZGP_IS_GIT a value
git rev-parse --is-inside-work-tree > /dev/null 2> /dev/null
if [[ $? -eq 0 ]]; then
  ZGP_IS_GIT=true
else
  ZGP_IS_GIT=false
fi

# parse porcelain status into STATUSES array
declare STATUS_RAW=$(git status --porcelain -b 2> /dev/null)
IFS=$'\n' read -rd '' -A STATUSES <<<"$STATUS_RAW"
unset STATUS_RAW

# calculate ZGP_STATUS_* values 
for STATUS in "${STATUSES[@]}";
do
  local CODE=$(echo $STATUS | cut -c 1-2)
  if [[ $CODE =~ ^##$ ]]; then
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
if [[ $ZGP_STATUS_BRANCH_AHEAD -eq 0 && $ZGP_STATUS_BRANCH_BEHIND -eq 0 ]]; then
  ZGP_STATUS_BRANCH_UP_TO_DATE=true
else
  ZGP_STATUS_BRANCH_UP_TO_DATE=false
fi

# for debugging purposes
# echo "is git: $ZGP_IS_GIT"
# echo "branch: $ZGP_BRANCH"
# echo "untracked: $ZGP_STATUS_UNTRACKED"
# echo "staged: $ZGP_STATUS_STAGED"
# echo "unstaged: $ZGP_STATUS_UNSTAGED"
# echo "branch ahead: $ZGP_STATUS_BRANCH_AHEAD"
# echo "branch behind: $ZGP_STATUS_BRANCH_AHEAD"
# echo "branch up to date: $ZGP_STATUS_BRANCH_UP_TO_DATE"

# TODO unset vars in zsh closing function thing
# unset ZGP_IS_GIT
# unset ZGP_BRANCH
# unset ZGP_STATUS_UNTRACKED
# unset ZGP_STATUS_STAGED
# unset ZGP_STATUS_UNSTAGED

# TODO
# manage the vars export and create a default prompt string 
  # get inspo from omz

