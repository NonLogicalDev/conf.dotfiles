#-------------------------------------------------------------------------------
# Utilites
#

# Checks if a file can be autoloaded by trying to load it in a subshell.
# function is-autoloadable {
#   ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
# }

# Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Prints the first non-empty string in the arguments array.
function coalesce {
  for arg in $argv; do
    print "$arg"
    return 0
  done
  return 1
}

#-------------------------------------------------------------------------------
# Platform Helpers
#

# OSTYPE   - type of the os 'linux*,darwin*,bsd*'
# MACHTYPE - type of the machine 'x86,x86_64,arm'
# CPUTYPE  - type of the machine 'arm7l'

# if (( $+commands[uname] )); then
#   if [[ "$(uname)" == "Darwin" ]]; then
#     PLATFORM="MAC"
#   elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
#     PLATFORM="LINUX"
#   elif [[ "$(expr substr $(uname -s) 2 10)" == "MINGW32_NT" ]]; then
#     PLATFORM="WIN"
#   fi
# fi

# if ! [[ -v PLATFORM ]]; then
#   PLATFORM="UNKNOWN"
# fi

# export PLATFORM

#-------------------------------------------------------------------------------
# Path Related Functions (BASH + ZSH)
#

function path_list {
  for p in $path
  do
    echo $p
  done
}

function path_dedup {
  if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
      x=${old_PATH%%:*}      # the first remaining entry
      case $PATH: in
        *:"$x":*) ;;         # already there
        *) PATH=$PATH:$x;;   # not there yet
      esac
      old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
  fi
}

function path_append() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

function path_prepend() {
  for ((i=$#; i>0; i--));
  do
    eval "ARG=\${$i}"
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}
