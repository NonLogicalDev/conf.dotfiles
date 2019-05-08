#######################################################################
#                           Global Bindings                           #
#######################################################################

# Loading Modules and extensions
zmodload zsh/terminfo
autoload -Uz edit-command-line && zle -N edit-command-line

zsh-widget-noop () {}
zle -N zsh-widget-noop

# Use human-friendly identifiers.
typeset -gA key_info
key_info=(
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

# pressing <ESC> in normal mode is bogus: you need to press 'i' twice to enter insert mode again.
# rebinding <ESC> in normal mode to something harmless solves the problem.
bindkey -M vicmd '\e' zsh-widget-noop

bindkey -M vicmd : edit-command-line

bindkey -M vicmd "$key_info[End]" end-of-line
bindkey -M vicmd "$key_info[Home]" beginning-of-line

bindkey -M viins "$key_info[End]" end-of-line
bindkey -M viins "$key_info[Home]" beginning-of-line

bindkey -M viins '^Y' yank
bindkey -M viins '^U' kill-whole-line

bindkey -M viins ' ' magic-space

# vi-backward-delete-char does not go back across newlines.
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^?" backward-delete-char
