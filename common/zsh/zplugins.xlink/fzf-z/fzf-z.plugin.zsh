#!/usr/bin/env zsh
#
# Based on https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
# (MIT licensed, as of 2016-05-05).

if [[ $OSTYPE == darwin* ]]; then
    REVERSER='tail -r'
else
    REVERSER='tac'
fi


__fzfz() {
    if (($+FZFZ_EXCLUDE_PATTERN)); then
        EXCLUDER="egrep -v '$FZFZ_EXCLUDE_PATTERN'"
    else
        EXCLUDER="cat"
    fi

    if (($+FZFZ_SUBBER_PATTERN)); then
        SUBBER="perl -pe '$FZFZ_SUBBER_PATTERN'"
    else
        SUBBER="cat"
    fi

    # EXCLUDER is applied directly only to searches that need it (i.e. not
    # `z`). That improvements performance, and makes sure that the
    # FZFZ_SUBDIR_LIMIT is applied on the post-excluded list.

    if (($+FZFZ_EXTRA_DIRS)); then
        EXTRA_DIRS="{ find $FZFZ_EXTRA_DIRS -type d 2> /dev/null | $EXCLUDER }"
    else
        EXTRA_DIRS="{ true }"
    fi

    FZFZ_SUBDIR_LIMIT=${FZFZ_SUBDIR_LIMIT:=150}

    REMOVE_FIRST="tail -n +2"
    LIMIT_LENGTH="head -n $(($FZFZ_SUBDIR_LIMIT+1))"

    SUBDIRS="{ find $PWD -type d | $EXCLUDER | $LIMIT_LENGTH | $REMOVE_FIRST | $SUBBER }"
    RECENTLY_USED_DIRS="{ z -l | $REVERSER | sed 's/^[[:digit:].]*[[:space:]]*//' | $SUBBER }"

    if command -v tree >/dev/null; then
      PRRVIEW_CMD="sh -c 'tree -L 1 -C \$(eval echo \"{}\")'"
    else
      PRRVIEW_CMD="echo "{}" && echo && sh -c 'ls -1 \$(eval echo \"{}\")'"
    fi


    FZF_COMMAND="fzf --tiebreak=index -m --preview=\" $PRRVIEW_CMD | head -\$LINES \""

    F_CMD="perl -pe '$FILTER_PAT'";

    local COMMAND="{ $RECENTLY_USED_DIRS; $EXTRA_DIRS; } | $FZF_COMMAND"

    eval "$COMMAND" | while read item; do
        printf '\"%s\" ' "$item"
    done
    echo
}

fzfz-file-widget() {
    RES=$(eval echo "$(__fzfz)")
    LBUFFER="${LBUFFER}$RES"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle     -N   fzfz-file-widget
bindkey '^G' fzfz-file-widget

__fzfz_dir() {
    REMOVE_FIRST="tail -n +2"
    LIMIT_LENGTH="head -n $(($FZFZ_SUBDIR_LIMIT+1))"

    SUBDIRS="{ ack -l '^' }"

    FZF_COMMAND='fzf -e --tiebreak=index -m --preview="cat {} | head -$LINES"'

    local COMMAND="{ $SUBDIRS ; } | $FZF_COMMAND"

    eval "$COMMAND" | while read item; do
        printf '\"%s\" ' "$item"
    done
    echo
}
fzfz-file-dir-widget() {
    RES=$(eval echo "$(__fzfz_dir)")
    LBUFFER="${LBUFFER}$RES"
    local ret=$?
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle     -N   fzfz-file-dir-widget
bindkey '^F' fzfz-file-dir-widget

