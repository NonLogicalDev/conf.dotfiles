export TASKW_DB="${HOME}/.taskwarrior"
export TIMEW_DB="${HOME}/.timewarrior"

function exists { which $1 &> /dev/null }

if [ -d "${TASKW_DB}/bin" ]; then
    export PATH="${TASKW_DB}/bin:$PATH"
fi

if exists 'task' && exists 'tw.task'; then
  rm -f "${HOME}/.taskrc"
  ln -s "${TASKW_DB}/taskwarrior.cfg" "${HOME}/.taskrc"

  alias ts='tw.task'
  alias ts.edit="bash -c 'cd ${TASKW_DB}/data.task && $EDITOR .'"
fi

if exists 'timew' && exists 'tw.time'; then
  rm -rf ${TIMEW_DB} > /dev/null
  mkdir -p ${TIMEW_DB} > /dev/null

  ln -s "${TASKW_DB}/timewarrior.cfg" "${TIMEW_DB}"
  ln -s ${TASKW_DB}/data.time/data "${TIMEW_DB}"
  ln -s ${TASKW_DB}/data.time/extensions "${TIMEW_DB}"

  alias ti='tw.time'
  alias ti.edit="bash -c 'cd ${TASKW_DB}/data.time && $EDITOR .'"
fi
