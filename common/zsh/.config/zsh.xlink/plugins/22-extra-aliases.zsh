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
  alias o='open'

elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'

  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'

elif [[ "$OSTYPE" == linux* ]]; then
  __open_cmd() {
    xdg-open "$@" 1> /dev/null 2> /dev/null & disown
  }
  alias o='__open_cmd'

  if (( $+commands[xclip] )); then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  fi

  if (( $+commands[xsel] )); then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi

  if (( $+commands[wl-copy] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  fi
fi

if [[ "$OSTYPE" == darwin* ]]; then
    # Change working directory to the top-most Finder window location
    function cdf() { # short for `cdfinder`
        cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')";
    }
fi
