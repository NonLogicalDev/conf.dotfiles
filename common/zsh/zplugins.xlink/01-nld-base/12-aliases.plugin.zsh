#######################################################################
#                               Aliases                               #
#######################################################################

alias oops='sudo $(fc -ln -1)'

alias x.copy=":"
alias x.paste=":"

alias tm.paste='tmux saveb - | x.copy'
alias tm.snap='tmux show-buffer | x.copy'

alias grepl='grep --line-buffered'

alias cdb='cd "+1"'
alias cdr='cd "$(realpath .)"'

# Location Aliases
alias go.dots='cd ~/.local/share/dotter'
alias go.conf='cd ~/.config/'
alias go.data='cd ~/.local/share/'

#######################################################################
#                                MacOS                                #
#######################################################################

if [[ $PLATFORM == "MAC" ]]; then
  alias go.docs='cd ~/Documents'
  alias go.pics='cd ~/Pictures'

  alias go.note='cd ~/Documents/Notes'

  alias x.curl='curl --cert $CU_CERT'

  alias x.copy="pbcopy"
  alias x.paste="pbpaste"

  function jet {
    APP="IntelliJ\ IDEA\ Ultimate"
    local args="$@"
    local root=$(git rev-parse --show-toplevel)

    if [ -z "$root" ] || [ -n "$args" ]; then
      open -a "$APP" "$@"
    else
      open -a "$APP" $root
    fi
  }

  alias jet.go='open -a GoLand'
  alias jet.py='open -a PyCharm'
  alias jet.web='open -a WebStorm'
fi

#######################################################################
#                                Linux                                #
#######################################################################

if [[ $PLATFORM == "LINUX" ]]; then
  if (( $+commands[xsel] )); then
    alias x.copy=":"
    alias x.paste=":"
  fi
fi
