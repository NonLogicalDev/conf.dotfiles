#######################################################################
#                           Global Bindings                           #
#######################################################################

# Loading Modules and extensions
zmodload zsh/terminfo
autoload -Uz edit-command-line && zle -N edit-command-line

zsh-widget-noop () {}
zle -N zsh-widget-noop

# pressing <ESC> in normal mode is bogus: you need to press 'i' twice to enter insert mode again.
# rebinding <ESC> in normal mode to something harmless solves the problem.
bindkey -M vicmd '\e' zsh-widget-noop

bindkey -M vicmd : edit-command-line

# bindkey -M vicmd "$key_info[End]" end-of-line
# bindkey -M vicmd "$key_info[Home]" beginning-of-line
# bindkey -M viins "$key_info[End]" end-of-line
# bindkey -M viins "$key_info[Home]" beginning-of-line

bindkey -M viins '^Y' yank
bindkey -M viins '^U' kill-whole-line

bindkey -M viins ' ' magic-space

# vi-backward-delete-char does not go back across newlines.
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^?" backward-delete-char
