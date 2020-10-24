# vim: ft=zsh
#######################################################################
#                              Functions                              #
#######################################################################

## Set up Open Command:
if [[ "$PLATFORM" == 'LINUX' ]]; then
  export OPEN_CMD=${commands[xdg-open]}
  function open() {
    "$OPEN_CMD" "$@" 1> /dev/null 2> /dev/null & disown
  }
elif [[ "$PLATFORM" == 'MAC' ]]; then
  export OPEN_CMD=${commands[open]}
fi

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


if [[ "$PLATFORM" == 'LINUX' ]]; then
  millis() {
    date '+%s%3N'
  }
elif [[ "$PLATFORM" == 'MAC' ]]; then
  if (( $+commands[gdate] )); then
    millis() {
      gdate '+%s%3N'
    }
  else
    millis() {
      python -c "import time; print(int(time.time()*1000))";
    }
  fi
fi

function git() {
  TS1=$(millis)

  local GIT_ROOT_DIR=$(command git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    exit 1
  fi

  # Find Index file:
  local GIT_INDEX_PATH=""
  if [[ ! -z $GIT_INDEX_FILE ]]; then
      # Index can be set manually:
      GIT_INDEX_PATH="${GIT_ROOT_DIR}/${GIT_INDEX_FILE}"
  else
    # Support detatched WorkTrees
    if [[ -f "${GIT_ROOT_DIR}/.git" ]]; then
      # If .git is a file, then this repo is a detached worktree.
      # Parse out the location of the worktree dir:
      GIT_WORKTREE_DIR=$(cat "${GIT_ROOT_DIR}/.git" | grep gitdir | sed 's/.*: //')
      GIT_INDEX_PATH="${GIT_WORKTREE_DIR}/index"
    else
      # In default case index is under .git dir:
      GIT_INDEX_PATH="${GIT_ROOT_DIR}/.git/index"
    fi
  fi

  if [[ 
    $1 != "" 
    && $1 != "st" 
    && $1 != "lg" 
    && $1 != "rev-parse" 
    && $1 != "symbolic-ref" 
    && $1 != "show" 
    && $1 != "merge-base" 
    && $1 != "info" 
    && $1 != "upstream" 
  ]]; then
    # Wait until git index becomes available.
    ( until [[ ! -f "${GIT_INDEX_PATH}.lock" ]]; do
        echo "Waiting for Git Index Lock" >&2
        sleep 0.2;
      done
    )
  fi

  command git "$@"

  TS2=$(millis)
  local CALLER=$(ps -o command=,pid= $(ps -o ppid= $$))
  echo "$GIT_INDEX_PATH :: $CALLER :: $(($TS2 - $TS1))ms  :: [$@] " >> ~/.gitlog
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

if (( $+commands[memo] )); then
  function meme() {
    memo read memes.yaml |
      python -c 'import yaml; import sys; import json; print json.dumps(yaml.load(sys.stdin))'
  }
fi

function lspath() {
  echo $PATH | tr ":" "\n"
}

function zsh-compile-dir() {
  find $1 -type f -iname $2 -exec zsh -c 'echo "Compiling: {}" && zcompile "{}"' \;
}
