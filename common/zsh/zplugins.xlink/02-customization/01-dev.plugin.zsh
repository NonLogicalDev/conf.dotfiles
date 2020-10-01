typeset -aU INIT_LIST
export INIT_LIST=()

## iTerm Integration
function init.iterm {
  if [[ -s "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    echo "INIT | iTerm..."

    source "${HOME}/.iterm2_shell_integration.zsh"
    INIT_LIST+=("iterm")
  fi
}

## Adding ASDF Version Manger
function init.vm.asdf {
  # export ASDF_DIR="$(brew --prefix asdf)"
  if [[ "$PLATFORM" == "MAC" ]]; then
    export ASDF_DIR="/usr/local/opt/asdf"
  fi

  if [[ -v ASDF_DIR && -d $ASDF_DIR ]]; then 
    echo "INIT | ASDF..."

    . "$ASDF_DIR/asdf.sh"
    . "$ASDF_DIR/etc/bash_completion.d/asdf.bash"
    INIT_LIST+=("asdf.vm")
  fi
  
  # declare -a plugins=(
  #   "ruby"
  #   "python"
  #   "lua"
  # )
  
  # for plug in "$plugins"; do
  #   asdf plugin-add $plug &> /dev/null
  # done
}

## Adding Node Version Manger
function init.vm.node {
  export NVM_DIR="$HOME/.nvm"

  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    echo "INIT | Node..."

    source "$NVM_DIR/nvm.sh"
    INIT_LIST+=("node.vm ($(node -v))")
  fi
}

## Adding Java Version Manger
function init.vm.java {
  export JVM_DIR="$HOME/.jenv"

  if (( $+commands[jenv] )); then 
    echo "INIT | JVM..."
    path_prepend "$JVM_DIR"

    source <(jenv init -)
    INIT_LIST+=("java.vm ($(java --version | head -n1))")
  fi
}

## Adding Rust Version Manger
function init.vm.rust {
  export CARGO_DIR="$HOME/.cargo"

  if [[ -s "$CARGO_DIR/env" ]]; then
    echo "INIT | RUST..."
    path=("$CARGO_DIR/bin" $path)

    source "$CARGO_DIR/env"
    INIT_LIST+=("rust.vm ($(cargo --version))")
  fi
}

## Adding Go Version Manger
function init.vm.go {
  export GIMME_DIR="$HOME/.gimme"

  if (( $+commands[gimme] )); then 
    echo "INIT | GO..."
    path_prepend "${GIMME_DIR}/go/bin"

    export GOPATH="${GIMME_DIR}/go"
    export GIMME_GO_VERSION="$(cat ${GIMME_DIR}/DEFAULT)"

    if [[ -z $GIMME_GO_VERSION ]]; then
      GIMME_GO_VERSION="$(gimme -k | tail -n1)"
      echo "Go Version Selected: $GIMME_GO_VERSION"
      echo "$GIMME_GO_VERSION" > "${GIMME_DIR}/DEFAULT"
    fi

    eval "$(GIMME_SILENT_ENV=1 gimme)" > /dev/null
    INIT_LIST+=("go.vm ($(go version))")
  fi
}

function init.ls {
  echo $INIT_LIST
}

function init.vmset.basic {
  init.iterm
}

function init.vmset.full {
  init.vmset.basic
  init.vm.node
  init.vm.java
  init.vm.rust
  init.vm.go
}

