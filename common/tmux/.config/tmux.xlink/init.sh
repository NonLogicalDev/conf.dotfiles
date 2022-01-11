#!/bin/bash

if command -v reattach-to-user-namespace > /dev/null 2>&1; then
  DEFAULT_SHELL=$(tmux show -gv default-shell)
  exec "$DEFAULT_SHELL" 2>/dev/null & reattach-to-user-namespace -l "$DEFAULT_SHELL"
fi
