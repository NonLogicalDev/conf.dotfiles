# Setting up brew
if [[ "$PLATFORM" == "LINUX" ]]; then
  path_prepend "$HOME/.linuxbrew/bin"
fi

# Add local Bin dirs
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
