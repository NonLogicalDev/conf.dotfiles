PLUGINS="
zsh-users/zsh-completions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
jcorbin/zsh-git path:functions kind:fpath
mafredri/zsh-async
NonLogicalDev/fork.util.zsh.pure-prompt
"

if which antibody 2>&1 > /dev/null; then
  if [ ! -f $HOME/.cache/zsh/antibody.zsh ]; then
    antibody init > $HOME/.cache/zsh/antibody.zsh
  fi
  source $HOME/.cache/zsh/antibody.zsh
  echo $PLUGINS | antibody bundle
fi

#======================================================================
# zsh-users/zsh-history-substring-search
#======================================================================

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#autoload -Uz promptinit && promptinit
