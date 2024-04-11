# Ensure Cache dir exists.
__zsh_cache_dir="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}"
if [[ ! -d $__zsh_cache_dir ]]; then
  mkdir -p "$__zsh_cache_dir"
fi

#-------------------------------------------------------------------------------
# Common Extra User Paths
#

path_append ~/bin
path_append ~/.local/bin

#-------------------------------------------------------------------------------
# General
#

setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents)
                            # with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.

#-------------------------------------------------------------------------------
# Commands
#

setopt CORRECT            # offer corrections for mistyped commands.

#-------------------------------------------------------------------------------
# Jobs
#

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.


#-------------------------------------------------------------------------------
# Completion
#

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

#-------------------------------------------------------------------------------
# History
#

setopt share_history
setopt extendedhistory
setopt histignorespace
setopt HIST_IGNORE_DUPS
setopt autocd autopushd pushdignoredups

export HISTSIZE=10000000 # The maximum number of events to save in the internal history.
export SAVEHIST=10000000 # The maximum number of events to save in the history file.

setopt INC_APPEND_HISTORY # append history incementally

export HISTFILE="${__zsh_cache_dir}/history"  # The path to the history file.
if [ ! -d "$(dirname $HISTFILE)" ]; then
  mkdir -p "$(dirname $HISTFILE)"
fi

#-------------------------------------------------------------------------------
# Termcap
#

export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.
