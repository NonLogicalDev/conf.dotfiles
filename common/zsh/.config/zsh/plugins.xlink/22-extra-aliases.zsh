#-------------------------------------------------------------------------------
# Aliases
#

alias oops='sudo $(fc -ln -1)'

if (( $+commands[sudo] )) && (( $+commands[apt] )); then
  alias apt='sudo apt'
fi

#-------------------------------------------------------------------------------
# Aliases: Developer Tools
#

if (( $+commands[git] )); then
  alias g=git
fi

if (( $+commands[kubectl] )); then
  alias k=kubectl
fi

#-------------------------------------------------------------------------------
# Aliases: MacOS Everywhere
#

if [[ "$OSTYPE" == darwin* ]]; then
    # Change working directory to the top-most Finder window location
    function cdf() { # short for `cdfinder`
        cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
    }
fi
