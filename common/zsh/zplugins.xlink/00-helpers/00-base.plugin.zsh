#######################################################################
#                       Path Related Functions                        #
#######################################################################

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
      x=${old_PATH%%:*}       # the first remaining entry
      case $PATH: in
        *:"$x":*) ;;         # already there
        *) PATH=$PATH:$x;;    # not there yet
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
