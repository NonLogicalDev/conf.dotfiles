function exists { which $1 &> /dev/null }

if [[ $OSTYPE == darwin* ]]; then
    REVERSER='tail -r'
else
    REVERSER='tac'
fi

if exists fzf; then
  function percol_select_history() {
    BUFFER=`eval "fc -l -n 1 | ${REVERSER} | fzf --query \"$LBUFFER\" --no-sort -e"`
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
    zle redisplay
  }
  zle -N percol_select_history
  bindkey '^R' percol_select_history
fi
