#######################################################################
#                               Aliases                               #
#######################################################################

alias oops='sudo $(fc -ln -1)'
alias grepl='grep --line-buffered'

alias cdb='cd "+1"'
if (( $+commands[realpath] )); then
  alias cdr='cd "$(realpath .)"'
fi

alias tmpaste='tmux saveb - | pbpaste'
alias tmcopy='tmux show-buffer | pbcopy'

# Location Aliases
alias go:conf='cd ~/.config/'
alias go:data='cd ~/.local/share/'

if (( $+commands[docker] )); then
  function drun() {
    local PRE_ARGS=()
    local ARGS=()
    while [[ $# -gt 0 ]]; do
      if [[ $1 == '--here' ]]; then
        PRE_ARGS+=(
          "-v" "$(pwd):/srv/mnt"
          "-w" "/srv/mnt"
        )
        shift
      else
        ARGS+=($1)
        shift
      fi
    done
    docker run --rm -ti "${PRE_ARGS[@]}" "${ARGS[@]}"
  }
  function dexec() {
    docker exec -ti "$@"
  }
fi

#######################################################################
#                           Developer Tools                           #
#######################################################################

if (( $+commands[git] )); then
  alias g=git
fi

if (( $+commands[kubectl] )); then
  alias k=kubectl
fi

#######################################################################
#                                MacOS                                #
#######################################################################

if [[ $PLATFORM == "MAC" ]]; then
  alias x.curl='curl --cert $CU_CERT'
  alias x.copy="pbcopy"
  alias x.paste="pbpaste"
fi

#######################################################################
#                                Linux                                #
#######################################################################
