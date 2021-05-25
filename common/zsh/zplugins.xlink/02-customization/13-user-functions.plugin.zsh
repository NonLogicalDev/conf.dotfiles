# vim: ft=zsh
#######################################################################
#                              Functions                              #
#######################################################################

if [[ "$OSTYPE" == linux* ]]; then
  __millis() {
    date '+%s%3N'
  }
elif [[ "$OSTYPE" == darwin* ]]; then
  if (( $+commands[gdate] )); then
    __millis() {
      gdate '+%s%3N'
    }
  else
    __millis() {
      python -c "import time; print(int(time.time()*1000))";
    }
  fi
fi

function rm() {
  local IS_R=0
  local IS_F=0
  local HAS_HOME=0
  local HAS_ROOT=0

  for arg in ${@}; do
    if [[ $arg == "-f" ]]; then
      IS_F=1
    fi

    if [[ $arg == "-r" ]]; then
      IS_R=1
    fi

    if [[ $arg == "-rf" || $arg == "-fr" ]]; then
      IS_F=1
      IS_R=1
    fi

    if [[ $arg == $HOME ]]; then
      HAS_HOME=1
    fi

    if [[ $arg == "/" ]]; then
      HAS_HOME=1
    fi
  done

  if [[ $IS_F -eq 1 && $IS_R -eq 1 ]]; then
    if [[ $HAS_HOME -eq 1 || $HAS_ROOT -eq 1 ]]; then
      echo "ERROR: Did you just??? rm $@" >&2
      echo "ERROR: Are you drunk? I ain't doing that for you." >&2
      return 128
    fi

    echo "Just Checking in..." >&2
    echo "You are running 'rm $@'" >&2
    echo "Are you totally sure? (y/n)" >&2
    read REPLY\?""

    if [[ $REPLY != "y" && $REPLY != "yes" ]]; then
      echo "ERROR: Abortring..." >&2
      return 128
    fi
  fi

  command rm -v $@
}

function git() {
  TS1=$(__millis)

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

  TS2=$(__millis)
  local CALLER=$(ps -o command=,pid= $(ps -o ppid= $$))
  echo "$GIT_INDEX_PATH :: $CALLER :: $(($TS2 - $TS1))ms  :: [$@] " >> ~/.gitlog
}