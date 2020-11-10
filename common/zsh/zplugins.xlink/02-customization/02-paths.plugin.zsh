# Setting up brew
if [[ "$PLATFORM" == "LINUX" ]]; then
  path_prepend "$HOME/.linuxbrew/bin"
fi

# Setting up Python3
if [[ "$PLATFORM" == "MAC" ]]; then
  for p in "$HOME/Library/Python/"*"/bin"; do
    path_prepend "$p"
  done
fi

# Setting up Kubeclt Krew
path_prepend "$HOME/.krew/bin"

# Add local Bin dirs
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
