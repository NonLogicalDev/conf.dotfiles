function exists { which $1 &> /dev/null }

if exists fzf; then
    function percol_select_history() {
        BUFFER="$(fc -l -n 1  | tail -r | fzf --query "$LBUFFER" --no-sort -e)"
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
        zle redisplay
    }
    zle -N percol_select_history
    bindkey '^R' percol_select_history

    alias fcd='change-directory-find'
    function change-directory-find() {
      SELECTED_DIR=$(find $* | percol)
      if [[ ! -z "$SELECTED_DIR" ]]; then
        cd $SELECTED_DIR
      fi
    }
fi
