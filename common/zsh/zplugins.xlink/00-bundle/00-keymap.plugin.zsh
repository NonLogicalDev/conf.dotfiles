# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
  }
  function zle-line-finish () {
    printf '%s' "${terminfo[rmkx]}"
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
# Use human-friendly identifiers.
typeset -g -A key
key=(
  'Tab'          '	'
  'ShiftTab'     '^[[Z'
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"

  'F1'           "$terminfo[kf1]"
  'F2'           "$terminfo[kf2]"
  'F3'           "$terminfo[kf3]"
  'F4'           "$terminfo[kf4]"
  'F5'           "$terminfo[kf5]"
  'F6'           "$terminfo[kf6]"
  'F7'           "$terminfo[kf7]"
  'F8'           "$terminfo[kf8]"
  'F9'           "$terminfo[kf9]"
  'F10'          "$terminfo[kf10]"
  'F11'          "$terminfo[kf11]"
  'F12'          "$terminfo[kf12]"
  'Insert'       "$terminfo[kich1]"
  'Home'         "$terminfo[khome]"
  'PageUp'       "$terminfo[kpp]"
  'End'          "$terminfo[kend]"
  'PageDown'     "$terminfo[knp]"
  'Up'           "$terminfo[kcuu1]"
  'Left'         "$terminfo[kcub1]"
  'Down'         "$terminfo[kcud1]"
  'Right'        "$terminfo[kcuf1]"
  'BackTab'      "$terminfo[kcbt]"
)

#######################################################################
#                        Setup default keymap.                        #
#######################################################################

bindkey -- "${key[Home]}"      beginning-of-line
bindkey -- "${key[End]}"       end-of-line

bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
bindkey -- "${key[PageDown]}"  end-of-buffer-or-history

bindkey -- "${key[Up]}"        up-line-or-history
bindkey -- "${key[Down]}"      down-line-or-history

bindkey -- "${key[Left]}"      backward-char
bindkey -- "${key[Right]}"     forward-char

bindkey -- "${key[Backspace]}" backward-delete-char
bindkey -- "${key[Delete]}"    delete-char

bindkey -- "${key[Insert]}"    overwrite-mode

#######################################################################
#                            Menu Complete                            #
#######################################################################
zmodload zsh/complist

bindkey -M menuselect -- "${key[Tab]}"       menu-complete 
bindkey -M menuselect -- "${key[ShiftTab]}"  reverse-menu-complete

