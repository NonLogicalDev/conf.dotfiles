#----------------------------------------------------------------------
# Language
#

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#----------------------------------------------------------------------
# Shell Settings:
#

IGNOREOF=10       # pressing Ctrl-D first 10 times will be ignored.
set -o ignoreeof  # \ (exits shell on 11th)
unsetopt nomatch  # Don't warn about glob pattern not matching any files.

#----------------------------------------------------------------------
# App Conifgs
#

#----------------------------------------------------------------------
# Editor
#

export PREFERRED_EDITOR=nano

if (( $+commands[nvim] )); then
  alias vim="nvim"
  export PREFERRED_EDITOR=$(which nvim)
elif (( $+commands[vim] )); then
  export PREFERRED_EDITOR=$(which vim)
elif (( $+commands[vi] )); then
  export PREFERRED_EDITOR=$(which vi)
fi

export EDITOR=${EDITOR:-$PREFERRED_EDITOR}
export VISUAL=${VISUAL:-$PREFERRED_EDITOR}
