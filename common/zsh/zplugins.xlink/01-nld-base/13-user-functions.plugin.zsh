# vim: ft=zsh
#######################################################################
#                              Functions                              #
#######################################################################

function cpd() {
  if [[ ${#*[@]} -le 1 ]]; then
    echo "Usage: [srcs...] [DST]"
    exit 1
  fi
  local target="${@[-1]}"
  local target_dir=$(dirname "$target")
  if [[ ! -a $dst ]]; then
    mkdir -p $target_dir
  fi
  cp "$@"
}

function git() {
  local GIT_DIR=$(command git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    exit 1
  fi

  # Support detatched WorkTrees
  if [[ -f "${GIT_DIR}/.git" ]]; then
    GIT_DIR=$(cat "${GIT_DIR}/.git" | grep gitdir | sed 's/.*: //')
  fi

  # Wait until git index becomes available.
  ( until [[ ! -f "${GIT_DIR}/.git/index.lock" && ! -f "${GIT_DIR}/index.lock" ]]; do
      echo "Waiting for Git Index Lock" >&2
      sleep 0.5;
    done
  ) && command git "$@"
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
  export OPEN_CMD=${commands[xdg-open]}
elif [[ "$PLATFORM" == 'MAC' ]]; then
  export OPEN_CMD=${commands[open]}
fi

if [ -x $OPEN_CMD ]; then
  function open() {
    "$OPEN_CMD" "$@" 1> /dev/null 2> /dev/null & disown
  }
fi

function zsh-compile-dir() {
  find $1 -type f -iname $2 -exec zsh -c 'echo "Compiling: {}" && zcompile "{}"' \;
}

function lspath() {
  echo $PATH | tr ":" "\n"
}
