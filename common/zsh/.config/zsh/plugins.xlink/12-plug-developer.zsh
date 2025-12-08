################################################################################
# General Version Managers:
################################################################################

# [Depreacted] Use mise like intended (moved activation to plugins)
#
# function init.vm.mise-use {
#   mise install "${1}"
#   ( rm -f /tmp/.mise.toml  && mise use "${1}" --path /tmp/.mise.toml )
#   eval "$(zsh -c 'cd /tmp && unset __RTX_DIFF __RTX_WATCH && mise hook-env -s zsh | grep -v __RTX')"
# }

################################################################################
# Language Version Managers:
################################################################################

## Go Version Manger (via RTX)
function init.vm.go {
  local INIT_VERSION="${1:-latest}"

  if init.vm.mise-use "go@${INIT_VERSION}"; then
    INIT_LIST[go]="mise: $(go version)"
  fi
}

## Node Version Manger (via RTX)
function init.vm.node {
  local INIT_VERSION="${1:-latest}"

  if init.vm.mise-use "node@${INIT_VERSION}"; then
    INIT_LIST[node]="mise: $(node version)"
  fi
}

## Java Version Manger (via RTX)
function init.vm.java {
  local INIT_VERSION="${1:-latest}"

  if init.vm.mise-use "java@${INIT_VERSION}"; then
    INIT_LIST[java]="mise: $(java version)"
  fi
}

## Python Version Manger (via RTX)
function init.vm.python {
  local INIT_VERSION="${1:-latest}"

  if init.vm.mise-use "python@${INIT_VERSION}"; then
    INIT_LIST[python]="mise: $(python --version)"
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
