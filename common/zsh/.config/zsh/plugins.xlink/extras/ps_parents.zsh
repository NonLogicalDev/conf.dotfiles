if [[ "$OSTYPE" == linux* ]]; then
  function __ps_parents() {
      local current_pid=$$
      local parent_pid

      echo "$current_pid"

      # Loop to traverse up the process tree
      while [ "$current_pid" -gt 1 ] && [ -n "$current_pid" ]; do
          # Get the parent PID and the command of the current PID
          read parent_pid cmd < <(ps -o ppid=,cmd= -p "$current_pid")

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
      while [ "$current_pid" -gt 1 ] && [ -n "$current_pid" ]; do
          # Get the parent PID and the command of the current PID
          read parent_pid cmd < <(ps -p "$current_pid" -o ppid= -o command=)

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
