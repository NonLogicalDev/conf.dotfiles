typeset -aU INIT_LIST
INIT_LIST=()
export INIT_LIST

## iTerm Integration
function init.iterm {
  if [[ -s "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    echo "INIT | iTerm..."

    . "${HOME}/.iterm2_shell_integration.zsh"
    INIT_LIST+=("iTerm")
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

    . "$NVM_DIR/nvm.sh"
    NVM_VER=`nvm use node`
    INIT_LIST+=("node.vm ($NVM_VER)")
  fi
}

## Adding Java Version Manger
function init.vm.java {
  export JVM_DIR="$HOME/.jenv"

  if [[ $+commands[jenv] ]]; then 
    echo "INIT | JVM..."

    path=("$JVM_DIR" $path)
    source <(jenv init -)
    INIT_LIST+=("java.vm")
  fi
}

function init.vmset.basic {
  init.iterm
  init.vm.asdf
  init.vm.java
}

function init.vmset.full {
  init.vmset.basic
  init.vm.node
}

