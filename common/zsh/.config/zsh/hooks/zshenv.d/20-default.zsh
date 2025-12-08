#!/bin/zsh

tt () {
  gdate +%s%3N
}

if [[ ! -z "$ZSH_COMPILE_SOURCE" ]]; then
  echo "COMPILING ON.."
  source () {
    [[ ! "$0.zwc" -nt "$1" || ! -f "$1.zwc" ]] || \
      ( echo "Compiling $0" && zcompile $1 )

    local t0=`tt`
    builtin source $@
    echo "SOURCED $(( $(tt) - $t0 )) > $1"
  }

  . () {
    [[ ! "$0.zwc" -nt "$1" || ! -f "$1.zwc" ]] || \
      ( echo "Compiling $0" && zcompile $1 )

    local t0=`tt`
    builtin . $@
    echo "SOURCED $(( $(tt) - $t0 )) > $1"
  }
fi

if [ ! -z "ZSH_PROFILE" ]; then
  zmodload zsh/zprof
fi

#######################################################################
#                           Define Platform                           #
#######################################################################

if (( $+commands[uname] )); then
  if [[ "$(uname)" == "Darwin" ]]; then
    PLATFORM="MAC"
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    PLATFORM="LINUX"
  elif [[ "$(expr substr $(uname -s) 2 10)" == "MINGW32_NT" ]]; then
    PLATFORM="WIN"
  fi
fi

if ! [[ -v PLATFORM ]]; then
  PLATFORM="UNKNOWN"
fi

export PLATFORM

#######################################################################
#                               Imports                               #
#######################################################################

export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 0 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
