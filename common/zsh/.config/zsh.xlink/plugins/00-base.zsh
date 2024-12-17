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
  for p in "${path[@]}"; do
    printf "%s\n" $p
  done
}

function path_dedup {
  local -A path_seen
  local -a new_path

  for p in "${path[@]}"; do
    if [[ -n ${path_seen[$p]} ]]; then
      continue
    fi

    path_seen[$p]=1
    new_path+=( "$p" )
  done

  path=( "${new_path[@]}")
}

function path_drop {
  local args=()
  if [[ $1 == '-' ]]; then
    while IFS= read -r a; do
      args+=( "$a" )
    done
  else
    args=( "$@" )
  fi

  local new_path=()
  for p in "${path[@]}"; do
    local match=0
    for pn in "${args[@]}"; do
      if [[ $p == $pn ]]; then
        match=1
        break
      fi
    done
    if [[ match -eq 1 ]]; then
      continue
    fi
    new_path+=( "$p" )
  done
  path=( "${new_path[@]}" )
}

function path_append {
  local args=()
  if [[ $1 == '-' ]]; then
    while IFS= read -r a; do
      args+=( "$a" )
    done
  else
    args=( "$@" )
  fi

  path_drop "${args[@]}"
  path=( "${path[@]}" "${args[@]}" )
}

function path_prepend {
  local args=()
  if [[ $1 == '-' ]]; then
    while IFS= read -r a; do
      args+=( "$a" )
    done
  else
    args=( "$@" )
  fi

  path_drop "${args[@]}"
  path=( "${args[@]}" "${path[@]}" )
}
