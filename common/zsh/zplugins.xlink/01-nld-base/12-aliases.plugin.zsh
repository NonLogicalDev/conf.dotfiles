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