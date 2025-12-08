#!/bin/zsh

#######################################################################
#                            Global/Perf                              #
#######################################################################

if [[ "$OSTYPE" == linux* ]]; then
  __millis() {
    date '+%s%3N'
  }
elif [[ "$OSTYPE" == darwin* ]]; then
  if (( $+commands[gdate] )); then
    __millis() {
      gdate '+%s%3N'
    }
  else
    __millis() {
      python -c "import time; print(int(time.time()*1000))";
    }
  fi
fi

declare -A __perf_runs=()

function __perf.ls {
  for key value in ${(kv)__perf_runs}; do
    printf "%s\t%s\n" "$key" "$value"
  done | column -t -s $'\t'
}

function __perf.run {
  local __perf_key=$1; shift 1
  __perf_run_ts_s=$(__millis)
  "$@"
  __perf_run_ts_e=$(__millis)
  __perf_run_td=$(( __perf_run_ts_e - __perf_run_ts_s ))
  __perf_runs[$__perf_key]="$__perf_run_td"
}

typeset -A __plug_recs=()

function __plug.ls {
  for key value in ${(kv)__plug_recs}; do
    printf "%s\t%s\n" "$key" "$value"
  done | column -t -s $'\t'
}

function __plug.set {
  __plug_recs[$1]=$2
}

function __plug.add {
  if [[ -n ${__plug_recs[$1]} ]]; then
    __plug_recs[$1]="${__plug_recs[$1]}\t$2"
  else
    __plug_recs[$1]=$2
  fi
}

#######################################################################
#                               Global                                #
#######################################################################

# Correctly display UTF-8 with combining characters.
if [[ -z "$TERM" ]]; then
  export TERM=dumb
fi

# Correctly display UTF-8 with combining characters.
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  setopt combiningchars
fi

[[ -r "/etc/zshrc_$TERM_PROGRAM" ]] && . "/etc/zshrc_$TERM_PROGRAM"

# Add completionks.
if [[ -d ${HOME}/.local/bin/completions ]]; then
  export fpath=(${HOME}/.local/bin/completions $fpath)
fi

#######################################################################
#                               Plugins                               #
#######################################################################

# Add zsh plugins
for plugin in $HOME/.config/zsh/plugins/*.zsh; do
  __perf.run "$plugin" source $plugin
done

