#-------------------------------------------------------------------------------
# No Correction (disable correction)
#

alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cp='nocorrect cp'
alias ebuild='nocorrect ebuild'
alias gcc='nocorrect gcc'
alias gist='nocorrect gist'
alias grep='nocorrect grep'
alias heroku='nocorrect heroku'
alias ln='nocorrect ln'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias rm='nocorrect rm'

#-------------------------------------------------------------------------------
# No Globbing (Disable globbing)
#

alias bower='noglob bower'
alias fc='noglob fc'
alias find='noglob find'
alias ftp='noglob ftp'
alias history='noglob history'
alias locate='noglob locate'
alias rake='noglob rake'
alias rsync='noglob rsync'
alias scp='noglob scp'
alias sftp='noglob sftp'

#-------------------------------------------------------------------------------
# Set up safe aliases
#

# Safe ops. Ask the user before doing anything destructive.
alias rmi="${aliases[rm]:-rm} -i"
alias mvi="${aliases[mv]:-mv} -i"
alias cpi="${aliases[cp]:-cp} -i"
alias lni="${aliases[ln]:-ln} -i"

alias rm='rmi'
alias mv='mvi'
alias cp='cpi'
alias ln='lni'


#-------------------------------------------------------------------------------
# LS (Color & Aliases)
#

if is-callable 'dircolors'; then
  # GNU Core Utilities
  alias ls="${aliases[ls]:-ls} --group-directories-first"

  # Call dircolors to define colors if they're missing
  if [[ -z "$LS_COLORS" ]]; then
    if [[ -s "$HOME/.dir_colors" ]]; then
      eval "$(dircolors --sh "$HOME/.dir_colors")"
    else
      eval "$(dircolors --sh)"
    fi
  fi

  alias ls="${aliases[ls]:-ls} --color=auto"
else
  # BSD Core Utilities

  # Define colors for BSD ls if they're not already defined
  if [[ -z "$LSCOLORS" ]]; then
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
  fi
  # Define colors for the completion system if they're not already defined
  if [[ -z "$LS_COLORS" ]]; then
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
  fi

  alias ls="${aliases[ls]:-ls} -G"
fi

alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
# alias sl='ls'            # I often screw this up.

#-------------------------------------------------------------------------------
# Grep (Color & Aliases)
#

export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

alias grep="${aliases[grep]:-grep} --color=auto"
