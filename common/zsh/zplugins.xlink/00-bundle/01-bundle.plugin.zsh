PLUGINS="
mafredri/zsh-async

changyuheng/fz

zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting

NonLogicalDev/fork.util.zsh.pure-prompt
"

if which antibody 2>&1 > /dev/null; then
  if [[ ! -f $HOME/.cache/zsh/antibody.zsh ]]; then
    antibody init > $HOME/.cache/zsh/antibody.zsh
  fi

  source $HOME/.cache/zsh/antibody.zsh
  echo $PLUGINS | antibody bundle

  export ZSH_ANTIBODY="loaded"
fi

#######################################################################
#                           PLUGIN CONFIGS                            #
#######################################################################

autoload -Uz promptinit
promptinit && prompt_pure_setup

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
