declare -a __ZSH_ANTIBODY_PLUGINS=(
  "mafredri/zsh-async"

  "zsh-users/zsh-completions"
  "zsh-users/zsh-syntax-highlighting"
  "zsh-users/zsh-history-substring-search"

  "nnao45/zsh-kubectl-completion"
  "hlissner/zsh-autopair"
)

ZSH_PLUGIN_DIR=$HOME/.config/zsh/plugins

# "NonLogicalDev/fork.util.zsh.pure-prompt"
# "rupa/z"
# "changyuheng/fz"

if (( $+commands[antibody] )); then
  local _ANTIBODY_PLUGIN_LIST="$ZSH_CACHE_DIR/antibody.plugins.txt"
  local _ANTIBODY_PLUGIN_INIT="$ZSH_CACHE_DIR/antibody.plugins.zsh"

  antibody-compile() {
    echo "COMPILING: $_ANTIBODY_PLUGIN_INIT"
    echo ${(j:\n:)__ZSH_ANTIBODY_PLUGINS} > "$_ANTIBODY_PLUGIN_LIST"
    antibody bundle < "$_ANTIBODY_PLUGIN_LIST" > "$_ANTIBODY_PLUGIN_INIT"
  }

  if [[ ! -f $_ANTIBODY_PLUGIN_INIT ]]; then
    antibody-compile
  fi
  source "$_ANTIBODY_PLUGIN_INIT"


  #=======================================
  # zsh-users/zsh-history-substring-search
  #=======================================
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
  [[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   history-substring-search-up
  [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" history-substring-search-down

  #=======================================
  # zsh-users/zsh-syntax-highlighting
  #=======================================
  ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
fi

#-------------------------------------------------------------------------------
# External Plugin Configurations:
#

#=======================================
# NonLogicalDev/shell.async-goprompt
#=======================================
if (( $+commands[goprompt] )); then
  eval "$(goprompt install zsh)"
fi

#=======================================
# ajeetdsouza/zoxide
#=======================================
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

#=======================================
# sharkdp/bat
#=======================================
if (( $+commands[bat] )); then
  alias cat="bat -p --pager=never"
fi

#=======================================
# ogham/exa
#=======================================
if (( $+commands[exa] )); then
  alias ls=exa
fi

#=======================================
# direnv/direnv
#=======================================
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

#=======================================
# history search (autin/fzf-history)
#=======================================
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
else
  FZF_CTRL_R_OPTS="-i"
  source "$ZSH_PLUGIN_DIR/extras/fzf-history.zsh"
fi

#=======================================
# vscode integration
#=======================================

if [[ "$OSTYPE" == linux* ]]; then
  function __ps_parents() {
      local current_pid=$$
      local parent_pid

      # Loop to traverse up the process tree
      while [ "$current_pid" -ne 1 ]; do
          # Get the parent PID and the command of the current PID
          read parent_pid cmd < <(ps -o ppid=,cmd= -p $current_pid)

          # Print current PID and command
          echo "$current_pid | $cmd"

          # Move to the parent PID for the next iteration
          current_pid=$parent_pid
      done

      # Finally, print the init process (PID 1)
      read cmd < <(ps -o cmd= -p 1)
      echo "1 | $cmd"
  }
elif [[ $OSTYPE == darwin* ]]; then
  function __ps_parents() {
      local current_pid=$$
      local parent_pid

      # Loop to traverse up the process tree
      while [ "$current_pid" -ne 1 ]; do
          # Get the parent PID and the command of the current PID
          read parent_pid cmd < <(ps -p $current_pid -o ppid= -o command=)

          # Print current PID and command
          echo "$current_pid | $cmd"

          # Move to the parent PID for the next iteration
          current_pid=$parent_pid
      done

      # Finally, print the init process (PID 1)
      read cmd < <(ps -p 1 -o command=)
      echo "1 | $cmd"
  }
fi
if (( $+functions[__ps_parents] )); then
  # Set up vscode as an editor if it exists in parent process chain.
  if (__ps_parents $$ | grep -q vscode); then
      export GIT_EDITOR="code --wait"
      export EDITOR="code --wait"
      export VISUAL="code --wait"
  fi
fi
