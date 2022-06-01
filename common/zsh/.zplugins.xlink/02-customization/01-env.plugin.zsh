#----------------------------------------------------------------------
# Language
#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#----------------------------------------------------------------------
# Shell Settings:
#

IGNOREOF=10       # pressing Ctrl-D first 10 times will be ignored.
set -o ignoreeof  # \ (exits shell on 11th)
unsetopt nomatch  # Don't warn about glob pattern not matching any files.

#----------------------------------------------------------------------
# Path Settings:
#

# Setting up Linuxbrew
if (( $+commands[brew] )); then
  if [[ "$OSTYPE" == linux* ]]; then
    path_prepend "$HOME/.linuxbrew/bin"
  fi
fi

# Setting up Python3
if [[ "$OSTYPE" == darwin* ]]; then
  for p in "$HOME/Library/Python/"*"/bin"; do
    path_prepend "$p"
  done
fi

# Setting up Python (poetry)
if [[ -d "$HOME/.poetry" ]]; then
    path_prepend "$HOME/.poetry/bin"
    source "$HOME/.poetry/env"
fi

#----------------------------------------------------------------------
# Basic Conf
#

if [[ "$OSTYPE" == darwin* ]]; then
  # Load up the identities from the KeyChain on MacOS
  ssh-add -K 2>/dev/null
fi

#----------------------------------------------------------------------
# App Conifgs
#

# FZF:
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  export FZFZ_EXCLUDE_PATTERN='.git/|env/'
fi

# Ansible:
if (( $+commands[ansible] )); then
  export ANSIBLE_NOCOWS=1
fi

# Homebrew:
if (( $+commands[homebrew] )); then
  if [[ "$OSTYPE" == darwin* ]]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  fi
fi

# (Neo)VIM:
if (( $+commands[homebrew] )); then
  export TERM_ITALICS='true'
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
fi

#----------------------------------------------------------------------
# Editor
#

export PREFERRED_EDITOR=nano

if (( $+commands[nvim] )); then
  alias vim="nvim"
  export PREFERRED_EDITOR="nvim"
elif (( $+commands[vim] )); then
  export PREFERRED_EDITOR="vim"
elif (( $+commands[vi] )); then
  export PREFERRED_EDITOR="vi"
fi

export EDITOR=$PREFERRED_EDITOR
export VISUAL=$PREFERRED_EDITOR

