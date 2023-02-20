typeset -A INIT_LIST=()

function init.list {
  for key value in ${(kv)INIT_LIST}; do
      echo "$key -> $value"
  done
}

## iTerm Integration
function init.term.iterm {
  if [[ -s "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    echo "INIT | iTerm..."

    source "${HOME}/.iterm2_shell_integration.zsh"
    INIT_LIST[iterm] = "iterm"
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

    INIT_LIST[asdf] = "asdf.vm"
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
  export NVM_NODE_VERSION=${NVM_NODE_VERSION:-$1}

  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    echo "INIT | Node..."

    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    if [[ -n $NVM_NODE_VERSION ]]; then
      nvm use "$NVM_NODE_VERSION"
    fi

    INIT_LIST[node]="node.vm ($(node -v))"
  fi
}

## Adding Java Version Manger
function init.vm.java {
  export JVM_DIR="$HOME/.jenv"

  if (( $+commands[jenv] )); then
    echo "INIT | JVM..."

    path_prepend "$JVM_DIR"

    source <(jenv init -)
    INIT_LIST[java]="java.vm ($(java --version | head -n1))"
  fi
}

## Adding Rust Version Manger
function init.vm.rust {
  export CARGO_DIR="$HOME/.cargo"

  if [[ -s "$CARGO_DIR/env" ]]; then
    echo "INIT | RUST..."

    path=("$CARGO_DIR/bin" $path)

    source "$CARGO_DIR/env"

    INIT_LIST[rust]="rust.vm ($(cargo --version))"
    echo ${INIT_LIST[rust]}
  fi
}

## Adding Go Version Manger
function init.vm.go {
  export GIMME_DIR="$HOME/.gimme"

  if (( $+commands[gimme] )); then
    echo "INIT | GO ..."

    path_prepend "${GIMME_DIR}/go/bin"

    export GOPATH="${GIMME_DIR}/go"
    export GIMME_GO_VERSION="${GIMME_GO_VERSION:-$1}"

    if [[ -z $GIMME_GO_VERSION ]]; then
      return 
    fi

    eval "$(GIMME_SILENT_ENV=1 gimme)"
    INIT_LIST[go]="go.vm ($(go version))"
    echo ${INIT_LIST[go]}
  fi
}

function init.vm.python {
  if [[ -d "$HOME/.pyenv" ]]; then
    echo "INIT | PYTHON ..."

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
    export PYENV_PYTHON_VERSION=${PYENV_PYTHON_VERSION:-$1}

    eval "$(pyenv init --path)"
    if [[ -n $PYENV_PYTHON_VERSION ]]; then
      pyenv local "$PYENV_PYTHON_VERSION"
    fi

    INIT_LIST[python]="python.vm ($(python --version 2>&1))"
    echo ${INIT_LIST[python]}
  fi
}

function init.vmset.basic {
  {
    init.term.iterm
    init.vm.python
  } > /dev/null 2>/dev/null
}

# Extras:

if [[ -d "$HOME/.krew" ]]; then
  # Setting up Kubeclt Krew
  path_prepend "$HOME/.krew/bin"
fi
