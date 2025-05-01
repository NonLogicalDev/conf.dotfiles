ZSH_PLUGIN_DIR=$HOME/.config/zsh/plugins

declare -ga __ZSH_ANTIBODY_PLUGINS=(
  "mafredri/zsh-async"

  "zsh-users/zsh-completions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-history-substring-search"

  "hlissner/zsh-autopair"
)

if (( $+commands[nix] )); then
  __ZSH_ANTIBODY_PLUGINS+=(
    "nix-community/nix-zsh-completions.git"
  )
fi

if (( $+commands[kubectl] )); then
  __ZSH_ANTIBODY_PLUGINS+=(
    "nnao45/zsh-kubectl-completion"
  )
fi

# "NonLogicalDev/fork.util.zsh.pure-prompt"
# "rupa/z"
# "changyuheng/fz"

if (( $+commands[antibody] )); then
  __plug.set antibody "v:$(antibody --version 2>&1 | awk '{print $NF}')"

  _ANTIBODY_PLUGIN_LIST="$ZSH_CACHE_DIR/antibody.plugins.txt"
  _ANTIBODY_PLUGIN_INIT="$ZSH_CACHE_DIR/antibody.plugins.zsh"

  antibody-compile() {
    echo "Plugins:"
    echo "${(j:\n:)__ZSH_ANTIBODY_PLUGINS}" | sed 's/^/ * /g'

    echo "COMPILING:" 
    echo " * $_ANTIBODY_PLUGIN_LIST -> $_ANTIBODY_PLUGIN_INIT"
    echo "${(j:\n:)__ZSH_ANTIBODY_PLUGINS}" > "$_ANTIBODY_PLUGIN_LIST"
    ( set -x; antibody bundle < "$_ANTIBODY_PLUGIN_LIST" > "$_ANTIBODY_PLUGIN_INIT" )

    echo "DONE"
  }
  if [[ ! -f $_ANTIBODY_PLUGIN_INIT ]]; then
    antibody-compile
  fi
  source "$_ANTIBODY_PLUGIN_INIT"

  #=======================================
  # zsh-users/zsh-history-substring-search
  #=======================================
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
  [[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   history-substring-search-up
  [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" history-substring-search-down

  #=======================================
  # zsh-users/zsh-syntax-highlighting
  #=======================================
  ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
fi

#-------------------------------------------------------------------------------
# External Plugin Configurations:
#

#=======================================
# NonLogicalDev/shell.async-goprompt
#=======================================
if (( $+commands[goprompt] )); then
  __plug.set goprompt "v:?.?.?"
  eval "$(goprompt install zsh)"
fi

#=======================================
# ajeetdsouza/zoxide
#=======================================
if (( $+commands[zoxide] )); then
  __plug.set zoxide "v:$(zoxide --version 2>&1 | awk '{print $NF}')"
  eval "$(zoxide init zsh)"
fi

#=======================================
# sharkdp/bat
#=======================================
if (( $+commands[bat] )); then
  __plug.set cat/bat "v:$(bat --version 2>&1 | awk '{print $NF}')"
  alias cat="bat -p --pager=never"
fi

#=======================================
# ogham/exa
#=======================================
if (( $+commands[exa] )); then
  __plug.set ls/exa "v:$(exa --version 2>&1 | awk 'NR==2{print $0}')"
  alias ls="exa --group-directories-first"
fi
if (( $+commands[eza] )); then
  __plug.set ls/eza "v:$(eza --version 2>&1 | awk 'NR==2{print $0}')"
  alias ls="eza --group-directories-first"
fi

#=======================================
# direnv/direnv
#=======================================
if (( $+commands[direnv] )); then
  __plug.set direnv "v:$(direnv --version 2>&1 | awk '{print $NF}')"
  eval "$(direnv hook zsh)"
fi

#=======================================
# mise
#=======================================
if (( $+commands[mise] )); then
  __plug.set mise "v:$(mise --version 2>&1 | awk '{print $1}')"
  eval "$(mise activate zsh)"
fi

#=======================================
# krew
#=======================================
if [[ -d "$HOME/.krew" ]]; then
  __plug.set kubectl/krew loaded
  path_prepend "$HOME/.krew/bin"
fi

#=======================================
# brew/linux
#=======================================
if (( $+commands[brew] )); then
fi

#=======================================
# Python3/user
#=======================================
if (( $+commands[python3] )); then
  PYTHON_USER_BIN=$(python3 -m site --user-base)/bin
  __plug.set "python3/user" "src:$PYTHON_USER_BIN"
  path_prepend "$PYTHON_USER_BIN"
fi

#=======================================
# Python3/poetry
#=======================================
if [[ -d "$HOME/.poetry" ]]; then
  path_prepend "$HOME/.poetry/bin"
  source "$HOME/.poetry/env"
fi

#=======================================
# history search (autin/fzf-history)
#=======================================
if (( $+commands[atuin] )); then
  __plug.set history/atuin "v:$(atuin --version 2>&1 | awk '{print $NF}')"
  eval "$(atuin init zsh)"
else
  __plug.set history/fzf "loaded"
  FZF_CTRL_R_OPTS="-i"
  source "$ZSH_PLUGIN_DIR/extras/fzf-history.zsh"
fi

#=======================================
# vscode integration
#=======================================

source "$ZSH_PLUGIN_DIR/extras/ps_parents.zsh"
if (( $+functions[__ps_parents] )); then
  # Set up vscode as an editor if it exists in parent process chain.
  if (__ps_parents $$ | grep -q vscode); then
      __plug.set "editor/vscode" "enabled"

      export GIT_EDITOR="code --wait"
      export EDITOR="code --wait"
      export VISUAL="code --wait"
  fi
  # Set up vscode as an editor if it exists in parent process chain.
  if (__ps_parents $$ | grep -q cursor); then
      __plug.set "editor/cursor" "enabled"

      export GIT_EDITOR="cursor --wait"
      export EDITOR="cursor --wait"
      export VISUAL="cursor --wait"
  fi
fi

#=======================================
# macos style commands
#=======================================
if [[ -f "$ZSH_PLUGIN_DIR/extras/macos_style_aliases.zsh" ]]; then
  source "$ZSH_PLUGIN_DIR/extras/macos_style_aliases.zsh"
  __plug.set macos-style-aliases "loaded (${__macos_added_aliases})"
fi

#=======================================
# FZF:
#=======================================
if (( $+commands[fzf] )); then
  __plug.set fzf "v:$(fzf --version 2>&1)"
  __plug.set config/fzf "loaded"
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  export FZFZ_EXCLUDE_PATTERN='.git/|env/'
fi

#=======================================
# Ansible:
#=======================================
if (( $+commands[ansible] )); then
  __plug.set config/ansible "loaded"
  export ANSIBLE_NOCOWS=1
fi

#=======================================
# Homebrew:
#=======================================
if (( $+commands[brew] )); then
  if [[ "$OSTYPE" == darwin* ]]; then
    __plug.set config/brew "loaded"
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  elif [[ "$OSTYPE" == linux* ]]; then
    __plug.set config/brew "loaded"
    path_prepend "$HOME/.linuxbrew/bin"
  fi
fi

#=======================================
# (Neo)VIM:
#=======================================
if (( $+commands[homebrew] )); then
  __plug.set config/neovim "loaded"
  export TERM_ITALICS='true'
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
fi

#=======================================
# DistroPrompt:
#=======================================
if [[ -f "$ZSH_PLUGIN_DIR/extras/distro-icon.zsh" ]]; then
  __plug.set extra/distroprompt "loaded"
  source "$ZSH_PLUGIN_DIR/extras/distro-icon.zsh"
fi
