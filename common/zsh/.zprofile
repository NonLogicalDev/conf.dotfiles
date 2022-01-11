#-------------------------------------------------------------------------------
# Terminal
#

if [[ -z $TERM ]]; then
  export TERM=dumb
fi

#-------------------------------------------------------------------------------
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#-------------------------------------------------------------------------------
# Language
#

# NOTE: This might cause issues
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# NOTE: This might cause issues
export LC_COLLATE="C"
export LC_ALL="C"

#-------------------------------------------------------------------------------
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
cdpath=(
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  /usr/local/{bin,sbin}
  $path
)

#-------------------------------------------------------------------------------
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
# export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESS='-g -i -M -R -S -w -z-4'
