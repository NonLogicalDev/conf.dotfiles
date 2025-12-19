# For single user nix installation (which sometimes is not correctly initialized)
_NIX_DAEMON_PATH=/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh;
if [[ -f $_NIX_DAEMON_PATH ]] && ! (( $+commands[nix] )); then
    echo >&2 "nix: re-loading";
    unset __ETC_PROFILE_NIX_SOURCED;
    source "$_NIX_DAEMON_PATH";
fi

# Fixup locale archive path
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
