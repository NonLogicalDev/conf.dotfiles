# Add nix profile integration (if exists)
if [[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
if [[ -d "$HOME/.nix-profile/share/zsh/site-functions/" ]]; then
    fpath+=( "$HOME/.nix-profile/share/zsh/site-functions/" )
fi
