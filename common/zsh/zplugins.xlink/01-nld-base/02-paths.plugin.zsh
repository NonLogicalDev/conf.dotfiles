# Setting up brew
if [[ "$PLATFORM" == "LINUX" ]]; then
  path_prepend "$HOME/.linuxbrew/bin"
fi

# Setting up Python3
if [[ "$PLATFORM" == "MAC" ]]; then
  path_prepend "$HOME/Library/Python/3.7/bin"
fi

# Add local Bin dirs
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
