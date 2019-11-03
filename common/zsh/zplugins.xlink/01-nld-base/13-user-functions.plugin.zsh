# vim: ft=zsh
#######################################################################
#                              Functions                              #
#######################################################################

function git() {
  local GIT_DIR=$(command git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    exit 1
  fi
  ( until [[ ! -f "${GIT_DIR}/.git/index.lock" ]]; do
      echo "Waiting for Git Lock" >&2
      sleep 0.5;
    done 
  ) && command git "$@"
}

function __cmd() {
  local cmdpath=`whence -ap "$1" | head -n 1`
  if [[ -x "$cmdpath" ]]; then
    echo "$cmdpath"
    return 0
  fi
  return 1
}

if (( $+commands[fzf] )); then
  function cdp {
    cd "$(dbranch | fzf)"
  }
fi

function vimd() {
  local OLD_PWD=$(pwd)
  cd $1 && vim .
  cd "$OLD_PWD"
}

if (( $+commands[tree] )); then
  function lst() {
    tree -L 2 -C $* | less
  }
fi

if [[ -v commands[memo] ]]; then
  function meme() {
    memo read memes.yaml |
      python -c 'import yaml; import sys; import json; print json.dumps(yaml.load(sys.stdin))'
  }
fi

if [[ "$PLATFORM" == 'LINUX' ]]; then
  export OPEN_CMD=$(__cmd xdg-open)
elif [[ "$PLATFORM" == 'MAC' ]]; then
  export OPEN_CMD=$(__cmd open)
fi

if [ -x $OPEN_CMD ]; then
  function open() {
    "$OPEN_CMD" $* > /dev/null 2>&1 & disown
  }
fi

function zsh-compile-dir() {
  find $1 -type f -iname $2 -exec zsh -c 'echo "Compiling: {}" && zcompile "{}"' \;
}

function lspath() {
  echo $PATH | tr ":" "\n"
}
