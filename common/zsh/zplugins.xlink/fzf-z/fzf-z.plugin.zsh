#!/usr/bin/env zsh
SCRIPT_DIR=`dirname ${BASH_SOURCE:-$0}`

# This script provides binding for chosing:
# - content dir
# - content file
# - parent dir
# - parent file

# Requirement is python and fzf
function exists { which $1 &> /dev/null }

if exists 'python' && exists 'fzf'; then
    __fzfz_join_by() { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

    if [[ $OSTYPE == darwin* ]]; then
        REVERSER='tail -r'
    else
        REVERSER='tac'
    fi

    fzfz-content-dir-widget() {
        local PREVIEW_COMMAND="bash -c 'ls {}' | head -$LINES"
        local FZF_COMMAND="fzf -e --tiebreak=index -m --preview=\"${PREVIEW_COMMAND}\""
        local LOOKUP_COMMAND="{ python ${SCRIPT_DIR}/fzf-z.py content-dirs; } | $FZF_COMMAND"

        RES=$(eval "$LOOKUP_COMMAND")
        LBUFFER="${LBUFFER}$RES"

        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }

    zle     -N   fzfz-content-dir-widget
    bindkey '^H' fzfz-content-dir-widget


    fzfz-content-file-widget() {
        local PREVIEW_COMMAND="bash -c 'ls {}' | head -$LINES"
        local FZF_COMMAND="fzf -e --tiebreak=index -m --preview=\"${PREVIEW_COMMAND}\""
        local LOOKUP_COMMAND="{ python ${SCRIPT_DIR}/fzf-z.py content-files; } | $FZF_COMMAND"

        RES=$(eval "$LOOKUP_COMMAND")
        LBUFFER="${LBUFFER}$RES"

        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }
    zle     -N   fzfz-content-file-widget
    bindkey '^J' fzfz-content-file-widget


    fzfz-parent-dir-widget() {
        local PREVIEW_COMMAND="bash -c 'ls {}' | head -$LINES"
        local FZF_COMMAND="fzf -e --tiebreak=index -m --preview=\"${PREVIEW_COMMAND}\""
        local LOOKUP_COMMAND="{ python ${SCRIPT_DIR}/fzf-z.py parent-dirs; } | $FZF_COMMAND"

        RES=$(eval "$LOOKUP_COMMAND")
        LBUFFER="${LBUFFER}$RES"

        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }
    zle     -N   fzfz-parent-dir-widget
    bindkey '^K' fzfz-parent-dir-widget


    fzfz-parent-files-widget() {
        local PREVIEW_COMMAND="bash -c 'cat {} 2>/dev/null || ls {}' | head -$LINES"
        local FZF_COMMAND="fzf -e --tiebreak=index -m --preview=\"${PREVIEW_COMMAND}\""
        local LOOKUP_COMMAND="{ python ${SCRIPT_DIR}/fzf-z.py parent-files; } | $FZF_COMMAND"

        RES=$(eval "$LOOKUP_COMMAND")
        LBUFFER="${LBUFFER}$RES"

        local ret=$?
        zle redisplay
        typeset -f zle-line-init >/dev/null && zle zle-line-init
        return $ret
    }

    zle     -N   fzfz-parent-files-widget
    bindkey '^L' fzfz-parent-files-widget
fi
