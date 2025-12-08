#!/bin/zsh

# ------------------------------------------------------------------------------
# Hook Loader Helper
# Loads all .zsh files from a directory in numeric order
# ------------------------------------------------------------------------------

nl_hooks_load() {
    local hook_dir="$1"
    
    if [[ -z "$hook_dir" ]]; then
        echo "Error: hl_hooks_load requires a directory path" >&2
        return 1
    fi
    
    if [[ ! -d "$hook_dir" ]]; then
        return 0  # Directory doesn't exist, silently skip
    fi
    
    # Load all .zsh files in the directory, sorted numerically
    # (N) - null glob: don't error if no matches
    # (on) - order numerically
    for hook_file in "$hook_dir"/*.zsh(Non); do
        if [[ -s "$hook_file" ]]; then
            source "$hook_file"
        fi
    done
}

