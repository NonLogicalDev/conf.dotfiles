#----------------------------------------------------------------------
# User Key Bindings:
#
# References:
# - https://www.twilio.com/blog/zsh-tricks-to-blow-your-mind
# - https://gist.github.com/acamino/2bc8df5e2ed0f99ddbe7a6fddb7773a6
# - https://nathangrigg.com/2014/04/zsh-push-line-or-edit
# - https://unix.stackexchange.com/questions/47349/what-does-zshs-magic-space-command-do
# - https://www.redhat.com/sysadmin/bash-bang-commands
# 

# Loading Modules and extensions
zmodload zsh/terminfo
autoload -Uz edit-command-line && zle -N edit-command-line

zsh-widget-noop () {}
zle -N zsh-widget-noop

bindkey -M viins " " magic-space

# pressing <ESC> in normal mode is bogus: you need to press 'i' twice to enter insert mode again.
# rebinding <ESC> in normal mode to something harmless solves the problem.
bindkey -M vicmd '\e' zsh-widget-noop
bindkey -M vicmd : edit-command-line

bindkey '^Q' push-line-or-edit

bindkey -M viins '^Y' yank
bindkey -M viins '^U' kill-whole-line

# vi-backward-delete-char does not go back across newlines.
bindkey -M viins "^H" backward-delete-char
bindkey -M viins "^?" backward-delete-char
