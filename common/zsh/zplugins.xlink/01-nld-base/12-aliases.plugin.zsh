#######################################################################
#                               Aliases                               #
#######################################################################

alias cdb='cd "+1"'
alias cdr='cd "$(realpath .)"'

alias oops='sudo $(fc -ln -1)'
alias grepl='grep --line-buffered'

alias x.copy=":"
alias x.paste=":"

alias tm.paste='tmux saveb - | x.copy'
alias tm.snap='tmux show-buffer | x.copy'

# Location Aliases
alias go:conf='cd ~/.config/'
alias go:data='cd ~/.local/share/'

alias lst="tree -L 2"

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

if [[ $PLATFORM == "LINUX" ]]; then
  if (( $+commands[xsel] )); then
    alias x.copy=":"
    alias x.paste=":"
  fi
fi
