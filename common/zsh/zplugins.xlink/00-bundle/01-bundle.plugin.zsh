PLUGINS="
mafredri/zsh-async

zsh-users/zsh-completions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search

NonLogicalDev/fork.util.zsh.pure-prompt
"
#jcorbin/zsh-git path:functions kind:fpath

if which antibody 2>&1 > /dev/null; then
  if [ ! -f $HOME/.cache/zsh/antibody.zsh ]; then
    antibody init > $HOME/.cache/zsh/antibody.zsh
  fi

  source $HOME/.cache/zsh/antibody.zsh
  echo $PLUGINS | antibody bundle

  export ZSH_ANTIBODY="loaded"
fi

#######################################################################
#                           PLUGIN CONFIGS                            #
#######################################################################

#=======================================
# zsh-users/zsh-history-substring-search
#=======================================

if [ ! -z "$ZSH_ANTIBODY" ]; then 
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'

  bindkey -- "${key[Up]}"   history-substring-search-up
  bindkey -- "${key[Down]}" history-substring-search-down
fi

#autoload -Uz promptinit && promptinit
