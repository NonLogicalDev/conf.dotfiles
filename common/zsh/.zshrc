#!/bin/zsh

#######################################################################
#                               Global                                #
#######################################################################

# Correctly display UTF-8 with combining characters.
if [[ -z "$TERM" ]]; then
  export TERM=dumb
fi

# Correctly display UTF-8 with combining characters.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  setopt combiningchars
fi

[ -r "/etc/zshrc_$TERM_PROGRAM" ] && . "/etc/zshrc_$TERM_PROGRAM"

# Add completions.
if [[ -d ${HOME}/.local/bin/completions ]]; then
  export fpath=(${HOME}/.local/bin/completions $fpath)
fi

#######################################################################
#                               Plugins                               #
#######################################################################

# Add zsh plugins
if [[ -d ${ZDOTDIR:-$HOME}/.zplugins ]]; then
  for plugin in ${ZDOTDIR:-$HOME}/.zplugins/**/*.plugin.zsh; do
    source $plugin
  done
fi

#######################################################################
#                               Safety                                #
#######################################################################


#######################################################################
#                               Imports                               #
#######################################################################

# Import Local settings
if [[ ! -f ${ZDOTDIR-$HOME}/.zshrc.local ]]; then
  touch ${ZDOTDIR:-$HOME}/.zshrc.local
fi
source ${ZDOTDIR:-$HOME}/.zshrc.local

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

if [[ -n $ZSH_EXTRA_SOURCE ]]; then
  source "$ZSH_EXTRA_SOURCE"
fi

export PATH="$HOME/.poetry/bin:$PATH"

# PROMPT_ASYNC_ZLE: ------------------------------------------------------------
fpath+=( "/Users/oleg.utkin/.local/share/zsh-funcs" )
autoload -Uz promptinit
promptinit && prompt_asynczle_setup
# ------------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
