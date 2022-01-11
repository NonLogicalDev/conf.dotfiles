declare -a __ZSH_ANTIBODY_PLUGINS=(
  "mafredri/zsh-async"

  "zsh-users/zsh-completions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-history-substring-search"

  "nnao45/zsh-kubectl-completion"
  "hlissner/zsh-autopair"

  "rupa/z"
  "changyuheng/fz"

  "NonLogicalDev/fork.util.zsh.pure-prompt"
)

if (( $+commands[antibody] )); then
  local _ANTIBODY_PLUGIN_LIST="$ZSH_CACHE_DIR/antibody.plugins.txt"
  local _ANTIBODY_PLUGIN_INIT="$ZSH_CACHE_DIR/antibody.plugins.zsh"

  antibody-compile() {
    echo "COMPILING: $_ANTIBODY_PLUGIN_INIT"
    echo ${(j:\n:)__ZSH_ANTIBODY_PLUGINS} > "$_ANTIBODY_PLUGIN_LIST"
    antibody bundle < "$_ANTIBODY_PLUGIN_LIST" > "$_ANTIBODY_PLUGIN_INIT"
  }

  if [[ ! -f $_ANTIBODY_PLUGIN_INIT ]]; then
    antibody-compile
  fi
  source "$_ANTIBODY_PLUGIN_INIT"

  #-------------------------------------------------------------------------------
  # Plugin Configurations:
  #

  autoload -Uz promptinit
  if [[ -z $ZSH_DISABLE_PROMPT ]]; then
    promptinit && prompt_pure_setup
  fi

  #=======================================
  # rupa/z
  #=======================================
  export _Z_DATA_DIR="$HOME/.cache/zsh/z"
  export _Z_DATA="$_Z_DATA_DIR/z"
  if [[ ! -d $_Z_DATA_DIR ]]; then
    rm -rf $_Z_DATA_DIR
    mkdir -p $_Z_DATA_DIR
  fi

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
