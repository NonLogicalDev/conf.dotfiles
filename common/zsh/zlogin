#
# Executes commands at login.
#

if (( $+commands[fortune] )); then
  # Lightening up the mood.
  # Print a random, hopefully interesting, adage.
  
  alias login_fortune="fortune"
  #alias login_fortune="fortune $HOME/.local/share/fortune"

  local DECORATOR=(cat)
  if (($+commands[lolcat])); then
    DECORATOR=(lolcat)
  fi
  
  # -t in zsh test checks if file descriptor is open.
  # the following test checks if stdin and stdout are open.
  if [[ -t 0 || -t 1 ]]; then
    export FORTUNE="`login_fortune`"
    echo $FORTUNE | "${DECORATOR[@]}"
  fi
fi
