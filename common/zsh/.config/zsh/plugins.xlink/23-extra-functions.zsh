# vim: ft=zsh
#######################################################################
#                              Functions                              #
#######################################################################

#> rm: an idiot proof wrapper, because sometimes I am that idiot
function rm() {
  local IS_R=0
  local IS_F=0
  local HAS_HOME=0
  local HAS_ROOT=0

  for arg in ${@}; do
    if [[ $arg == "-f" ]]; then
      IS_F=1
    fi

    if [[ $arg == "-r" ]]; then
      IS_R=1
    fi

    if [[ $arg == "-rf" || $arg == "-fr" ]]; then
      IS_F=1
      IS_R=1
    fi

    if [[ $arg == $HOME ]]; then
      HAS_HOME=1
    fi

    if [[ $arg == "/" ]]; then
      HAS_HOME=1
    fi
  done

  if [[ $IS_F -eq 1 && $IS_R -eq 1 ]]; then
    if [[ $HAS_HOME -eq 1 || $HAS_ROOT -eq 1 ]]; then
      echo "ERROR: Did you just??? rm $@" >&2
      echo "ERROR: Are you drunk? I ain't doing that for you." >&2
      return 128
    fi

    echo "Just Checking in..." >&2
    echo "You are running 'rm $@'" >&2
    echo "Are you totally sure? (y/n)" >&2
    read REPLY\?""

    if [[ $REPLY != "y" && $REPLY != "yes" ]]; then
      echo "ERROR: Abortring..." >&2
      return 128
    fi
  fi

  command rm -v $@
}

#> lspath: print all components of the path
function lspath() {
    for p in $path; do
        echo $p
    done
}
