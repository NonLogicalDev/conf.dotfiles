#=======================================
# Super minimal prompt
#
#   [exit_code] [duration] [pwd]
#   $ $CURSOR
#
#=======================================

function __microprompt_pwd() {
  # produce compressed pwd string ~/[f/I/g]/last/2dirs
  local pwd_parts=(${(s:/:)PWD})
  local part_count=${#pwd_parts[@]}
  local compressed_pwd=""
  local home_prefix=""

  # Handle home directory
  if [[ "$PWD" == "$HOME" ]]; then
    echo "~"
    return
  elif [[ "$PWD" == "$HOME/"* ]]; then
    home_prefix="~"
    pwd_parts=(${(s:/:)${PWD#$HOME/}})
    part_count=${#pwd_parts[@]}
  fi

  # Handle root directory
  if [[ "$PWD" == "/" ]]; then
    echo "/"
    return
  fi

  # Build compressed path
  if [[ $part_count -le 2 ]]; then
    # For shallow paths, show full path
    if [[ -n "$home_prefix" ]]; then
      echo "$home_prefix/${(j:/:)pwd_parts}"
    else
      echo "/${(j:/:)pwd_parts}"
    fi
    return
  fi

  # Compress middle parts
  for (( i=0; i<part_count-2; i++ )); do
    if [[ "${pwd_parts[i+1]}" == .* ]]; then
      compressed_pwd+="${pwd_parts[i+1]:0:2}/"
    else
      compressed_pwd+="${pwd_parts[i+1]:0:1}/"
    fi
  done

  # Add last two parts
  compressed_pwd+="${pwd_parts[part_count-1]}/${pwd_parts[part_count]}"

  if [[ -n "$home_prefix" ]]; then
    echo "$home_prefix/$compressed_pwd"
  else
    echo "/$compressed_pwd"
  fi
}

function __microprompt_prompt_cmd_duration() {
  if [[ -z "$__MICROPROMPT_LAST_CMD_START_TIME" ]]; then
    return
  fi

  local duration=$(( EPOCHSECONDS - __MICROPROMPT_LAST_CMD_START_TIME ))
  if [[ $duration -lt 1 ]]; then
    return
  fi

  local minutes=$((duration / 60))
  local seconds=$((duration % 60))

  if [[ $minutes -gt 0 ]]; then
    echo "${minutes}m${seconds}s"
  else
    echo "${seconds}s"
  fi
}

function __microprompt_prompt_cmd_exit_code() {
  if [[ $__MICROPROMPT_LAST_CMD_EXIT_CODE -eq 0 ]]; then
    return
  fi

  echo "$__MICROPROMPT_LAST_CMD_EXIT_CODE"
}

function __microprompt_prompt_date() {
  echo "%F{blue}$(date +%Y-%m-%dT%H:%M:%S)%f"
}

function __microprompt_prompt_preexec() {
  __MICROPROMPT_LAST_CMD_START_TIME=$EPOCHSECONDS
}

function __microprompt_prompt_precmd() {
  __MICROPROMPT_LAST_CMD_EXIT_CODE=$?
}

function __microprompt_prompt_newline() {
  echo $'\n%{\r%}'
}

function __microprompt_prompt_func() {
  if (( __MICROPROMPT_ENABLE_ERICHMENTS != 1 )); then
    return
  fi

  local prompt_parts=()

  # Add date
  prompt_parts+=("$(__microprompt_prompt_date)")

  # Add exit code if non-zero
  local exit_code_part="$(__microprompt_prompt_cmd_exit_code)"
  if [[ -n "$exit_code_part" ]]; then
    prompt_parts+=("%F{red}[$exit_code_part]%f")
  fi

  # Add current directory
  prompt_parts+=("$(__microprompt_pwd)")

  # Add duration if command took time
  local duration_part="$(__microprompt_prompt_cmd_duration)"
  if [[ -n "$duration_part" ]]; then
    prompt_parts+=("%F{yellow}($duration_part)%f")
  fi

  if (( __MICROPROMPT_ENABLE_NEWLINE == 1 )); then
    echo "${(j: :)prompt_parts}$(__microprompt_prompt_newline)"
  else
    echo "${(j: :)prompt_parts} "
  fi
}

function microprompt_init() {
  __plug.set microprompt "v:?.?.?"

  zmodload zsh/datetime || :
  autoload -Uz +X promptinit 2>/dev/null
  autoload -Uz +X add-zsh-hook 2>/dev/null

  setopt PROMPT_SUBST

  # Set up hooks
  add-zsh-hook preexec __microprompt_prompt_preexec
  add-zsh-hook precmd __microprompt_prompt_precmd

  PROMPT='$(__microprompt_prompt_func)$ '

  function microprompt_split() {
    __MICROPROMPT_ENABLE_NEWLINE=$((1 - __MICROPROMPT_ENABLE_NEWLINE))
  }

  __MICROPROMPT_ENABLE_ERICHMENTS=1
  function microprompt_hide() {
    __MICROPROMPT_ENABLE_ERICHMENTS=$((1 - __MICROPROMPT_ENABLE_ERICHMENTS))
  }
}
