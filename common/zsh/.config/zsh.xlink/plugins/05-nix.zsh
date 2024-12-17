if [[ -f /usr/lib/locale/locale-archive ]]; then
    # This configuration is necessary for Nix to work properly on your system.
    # It sets the LOCALE_ARCHIVE environment variable, which points to the location
    # of the locale-archive file. This file contains compiled locale data, which is
    # required for proper localization support in various applications.
    # For more information, see: https://nixos.wiki/wiki/Locales
    export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
fi

# Add nix profile integration (if exists)
if [[ -s "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Add nix profile function integration (if exists)
if [[ -d "$HOME/.nix-profile/share/zsh/site-functions/" ]]; then
    fpath+=( "$HOME/.nix-profile/share/zsh/site-functions/" )
fi
