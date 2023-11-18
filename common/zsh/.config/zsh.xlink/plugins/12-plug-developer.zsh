typeset -A INIT_LIST=()

function init.list {
  for key value in ${(kv)INIT_LIST}; do
    echo "$key -> $value"
  done
}

################################################################################
# General Version Managers:
################################################################################

## RTX Version Manger (ASDF compatible)
function init.vm.rtx {
  [[ -n ${INIT_LIST[rtx]} ]] && return

  if ! (( $+commands[rtx] )); then
    return 1
  fi

  eval "$(rtx activate zsh)"
  INIT_LIST[rtx]="rtx.vm: $(rtx version)"
}

function init.vm.rtx-use {
  init.vm.rtx || return $?

  rtx install "${1}"

  ( rm -f /tmp/.rtx.toml  && rtx use "${1}" --path /tmp/.rtx.toml ) 
  eval "$(zsh -c 'cd /tmp && unset __RTX_DIFF __RTX_WATCH && rtx hook-env -s zsh | grep -v __RTX')"
}

################################################################################
# Language Version Managers:
################################################################################


## Go Version Manger (via RTX)
function init.vm.go {
  local INIT_VERSION="${1:-latest}"

  if init.vm.rtx-use "go@${INIT_VERSION}"; then 
    INIT_LIST[go]="rtx: $(go version)"
  fi
}

## Node Version Manger (via RTX)
function init.vm.node {
  local INIT_VERSION="${1:-latest}"

  if init.vm.rtx-use "node@${INIT_VERSION}"; then 
    INIT_LIST[node]="rtx: $(node version)"
  fi
}

## Java Version Manger (via RTX)
function init.vm.java {
  local INIT_VERSION="${1:-latest}"

  if init.vm.rtx-use "java@${INIT_VERSION}"; then 
    INIT_LIST[java]="rtx: $(java version)"
  fi
}

## Python Version Manger (via RTX)
function init.vm.python {
  local INIT_VERSION="${1:-latest}"

  if init.vm.rtx-use "python@${INIT_VERSION}"; then 
    INIT_LIST[python]="rtx: $(python --version)"
  fi
}

## Rust Version Manger (via Cargo)
function init.vm.rust {
  export CARGO_DIR="$HOME/.cargo"

  if ! [[ -s "$CARGO_DIR/env" ]]; then
    return 1
  fi

  path=("$CARGO_DIR/bin" $path)
  source "$CARGO_DIR/env"
  INIT_LIST[rust]="cargo: $(cargo --version)"
}


################################################################################
# Utilities:
################################################################################

## iTerm Integration
function init.term.iterm {
  if [[ -s "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    echo "INIT | iTerm..."

    source "${HOME}/.iterm2_shell_integration.zsh"
    INIT_LIST[iterm] = "iterm"
  fi
}

################################################################################
# Auto Init (auto detect integrations)
################################################################################

if [[ -d "$HOME/.krew" ]]; then
  # Setting up Kubeclt Krew
  path_prepend "$HOME/.krew/bin"
fi
