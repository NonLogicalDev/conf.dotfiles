#-------------------------------------------------------------------------------
# Aliases
#

alias oops='sudo $(fc -ln -1)'

# Location Aliases
alias go:conf='cd ~/.config/'
alias go:data='cd ~/.local/share/'

#-------------------------------------------------------------------------------
# Developer Tools
#

if (( $+commands[git] )); then
  alias g=git
fi

if (( $+commands[kubectl] )); then
  alias k=kubectl
fi