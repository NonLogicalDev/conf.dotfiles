declare -a __ZSH_ANTIBODY_PLUGINS=(
  "mafredri/zsh-async"

  "zsh-users/zsh-completions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-history-substring-search"

  "nnao45/zsh-kubectl-completion"
  "hlissner/zsh-autopair"


  "NonLogicalDev/fork.util.zsh.pure-prompt"
)

# "rupa/z"
# "changyuheng/fz"

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
  eval "$(goprompt install zsh)"
fi

#=======================================
# ajeetdsouza/zoxide
#=======================================
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

#=======================================
# sharkdp/bat
#=======================================
if (( $+commands[bat] )); then
  alias cat="bat -p --pager=never"
fi

#=======================================
# ogham/exa
#=======================================
if (( $+commands[exa] )); then
  alias ls=exa
fi

#=======================================
# direnv/direnv
#=======================================
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
