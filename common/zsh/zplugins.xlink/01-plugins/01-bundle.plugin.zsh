declare -a __ZSH_ANTIBODY_PLUGINS=(
  "mafredri/zsh-async"

  "zsh-users/zsh-completions"
  "nnao45/zsh-kubectl-completion"

  "zsh-users/zsh-history-substring-search"
  "NonLogicalDev/fork.util.zsh.pure-prompt"

  "rupa/z"
  "changyuheng/fz"

  "zsh-users/zsh-syntax-highlighting"
)

ZSH_CACHE_DIR="$HOME/.cache/zsh"

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
fi

#######################################################################
#                           PLUGIN CONFIGS                            #
#######################################################################

autoload -Uz promptinit
promptinit && prompt_pure_setup

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

if [[ ! -z "$ZSH_ANTIBODY" ]]; then
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
  [[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   history-substring-search-up
  [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" history-substring-search-down
fi

#=======================================
# zsh-users/zsh-syntax-highlighting
#=======================================

ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
