# ZSH MOON PHASE
#   determines the current (basic) moon phase
#
# Prerequisites: a patched font, aka nerd font
#
# exposes ZMP_PHASE and ZMP_PHASE_SYM for use in your zshrc
#   ZMP_PHASE       - a number from 1 (new moon) to 28 (last phase before new moon) 
#                   - full moon is 15
#   ZMP_PHASE_SYM   - default moon symbol. can be changed to non-outlined version below
#                   - outlined examples:    
#                   - non-outlined examples:    
# inspired by https://github.com/kevinboone/moonphase.h


# TODO expose this for editing outside of this file
declare USE_OUTLINED_SYMBOLS=true

declare -a PHASE_SYMS=(
    'e38d'
    'e3a8'
    'e3a7'
    'e3a6'
    'e3a5'
    'e3a4'
    'e3a3'
    'e3a2'
    'e3a1'
    'e3a0'
    'e39f'
    'e39e'
    'e39d'
    'e39c'
    'e39b'
    'e39a'
    'e399'
    'e398'
    'e397'
    'e396'
    'e395'
    'e394'
    'e393'
    'e392'
    'e391'
    'e390'
    'e38f'
    'e38e'
)

declare -a PHASE_SYMS_OUTLINED=(
    'e3d5'
    'e3d4'
    'e3d3'
    'e3d2'
    'e3d1'
    'e3d0'
    'e3cf'
    'e3ce'
    'e3cd'
    'e3cc'
    'e3cb'
    'e3ca'
    'e3c9'
    'e3c8'
    'e3e3'
    'e3e2'
    'e3e1'
    'e3e0'
    'e3df'
    'e3de'
    'e3dd'
    'e3dc'
    'e3db'
    'e3da'
    'e3d9'
    'e3d8'
    'e3d7'
    'e3d6'
)

declare -a SYMBOLS

if [[ $USE_OUTLINED_SYMBOLS == true ]]; then
    SYMBOLS=("${PHASE_SYMS_OUTLINED[@]}") 
else
    SYMBOLS=("${PHASE_SYMS[@]}") 
fi

declare NEW_MOON_REF='TZ="Africa/Johannesburg" 2024-04-08 20:20:49'

declare -i REF_FROM_EPOCH=`date --date "$NEW_MOON_REF" +%s`
declare -i NOW_FROM_EPOCH=`date +%s`

declare -i SYNODIC_SECONDS=2551443

declare -i DATE_DIFF=$(((NOW_FROM_EPOCH - REF_FROM_EPOCH) % SYNODIC_SECONDS))

if (( DATE_DIFF < 0 )); then
  DATE_DIFF=$((DATE_DIFF+SYNODIC_SECONDS))
fi

# as a number from 1 (new moon) to 28 (final waning crescent moon)
declare -ix ZMP_PHASE=$(((28 * DATE_DIFF / SYNODIC_SECONDS) + 1))
declare -x ZMP_PHASE_SYM="\u${SYMBOLS[ZMP_PHASE]}"

# for testing
# echo -e "$ZMP_PHASE_SYM | $ZMP_PHASE \u${PHASE_SYMS_OUTLINED[ZMP_PHASE]} \u${PHASE_SYMS[ZMP_PHASE]}"

unset USE_OUTLINED_SYMBOLS
unset PHASE_SYMS
unset PHASE_SYMS_OUTLINED
unset SYMBOLS
unset NEW_MOON_REF
unset REF_FROM_EPOCH
unset NOW_FROM_EPOCH
unset SYNODIC_SECONDS
unset DATE_DIFF

# TODO unset ZMP_PHASE and ZMP_PHASE_SYM in closing function thing

