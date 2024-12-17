declare -a __macos_added_aliases

macos_style_add_alias() {
  alias "$1"="$2"
  __macos_added_aliases+=("$1")
}

if [[ "$OSTYPE" == darwin* ]]; then
  macos_style_add_alias o 'open'

elif [[ "$OSTYPE" == cygwin* ]]; then
  __open_cmd() {
    cygstart "$@"
  }
  macos_style_add_alias o '__open_cmd'
  macos_style_add_alias open '__open_cmd'

  macos_style_add_alias pbcopy 'tee > /dev/clipboard'
  macos_style_add_alias pbpaste 'cat /dev/clipboard'

elif [[ "$OSTYPE" == linux* ]]; then
  __open_cmd() {
    xdg-open "$@" 1> /dev/null 2> /dev/null & disown
  }
  macos_style_add_alias o '__open_cmd'
  macos_style_add_alias open '__open_cmd'

  if [[ "$XDG_SESSION_TYPE" == "wayland" ]] && (( $+commands[wl-copy] )); then
    macos_style_add_alias pbcopy 'wl-copy'
    macos_style_add_alias pbpaste 'wl-paste'
  elif (( $+commands[xclip] )); then
    macos_style_add_alias pbcopy 'xclip -selection clipboard -in'
    macos_style_add_alias pbpaste 'xclip -selection clipboard -out'
  elif (( $+commands[xsel] )); then
    macos_style_add_alias pbcopy 'xsel --clipboard --input'
    macos_style_add_alias pbpaste 'xsel --clipboard --output'
  fi
fi

# Unset the function and array
unset -f macos_style_add_alias
