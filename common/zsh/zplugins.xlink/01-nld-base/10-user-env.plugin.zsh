#######################################################################
#                              Language                               #
#######################################################################

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#######################################################################
#                           Global Options                            #
#######################################################################

IGNOREOF=10
set -o ignoreeof
unsetopt nomatch

setopt share_history
setopt histignorespace
setopt HIST_IGNORE_DUPS
setopt autocd autopushd pushdignoredups

export HISTFILE="${HOME}/.cache/zsh/history"  # The path to the history file.
if [ ! -d "$(dirname $HISTFILE)" ]; then
  mkdir -p "$(dirname $HISTFILE)"  
fi
export HISTSIZE=1000000 # The maximum number of events to save in the internal history.
export SAVEHIST=1000000 # The maximum number of events to save in the history file.

#######################################################################
#                             Basic Conf                              #
#######################################################################

if [[ "$PLATFORM" == 'MAC' ]]; then
  ssh-add -K 2>/dev/null
fi

#######################################################################
#                             App Conifgs                             #
#######################################################################

# FZF:
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export FZFZ_EXCLUDE_PATTERN='.git/|env/'

# Ansible:
export ANSIBLE_NOCOWS=1

# Homebrew:
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# VIM:
export TERM_ITALICS='true'
export NVIM_TUI_ENABLE_TRUE_COLOR=1

#######################################################################
#                               Editor                                #
#######################################################################

export EDITOR="vim"
export VISUAL="vim"

if [[ -v commands[nvim] ]]; then
  alias vim="nvim"
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

#######################################################################
#                               Editor                                #
#######################################################################
sman() {
  local MAXMANWIDTH=120
  if [[ $COLUMNS -gt $MAXMANWIDTH ]]; then
    MANWIDTH=$MAXMANWIDTH man "$@"
  else
    man "$@"
  fi
}
alias man="sman"
compdef sman="man"

