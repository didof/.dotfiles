#!/usr/bin/env bash

set -euo pipefail # at first error, break pipe

# cloning
install_path=$HOME/.dotfiles
if [ ! -d "$install_path" ]; then
  $git clone https://github.com/didof/.dotfiles "$install_path"
fi

function install_stow {
    stow -v stow
}

function move_userdirs {
    if test -f "$HOME/.config/user-dirs.dirs"; then
        mv "$HOME/.config/user-dirs.dirs" "$HOME/.config/user-dirs.dirs.bck" || true
    fi
    if test -f "$HOME/.config/user-dirs.locale"; then
        mv "$HOME/.config/user-dirs.locale" "$HOME/.config/user-dirs.locale.bck" || true
    fi
}

function ensure_userdirs {
    if test -f "$install_path/userdirs/.config/user-dirs.dirs"; then
        while IFS='' read -r line || [[ -n "$line" ]]; do
            if [[ ! "$line" =~ ^# ]]; then
                loc=$(echo "$line" | sed 's/XDG_.*_DIR="\(.*\)"/\1/' | envsubst)
                [[ -n "$loc" ]] && mkdir -p "$loc"
            fi
        done < "$install_path/userdirs/.config/user-dirs.dirs"
    fi
}

function install_userdirs {
    move_userdirs
    stow -v userdirs
    ensure_userdirs
}

function install_bash {
    stow -v bash
}

function install_fonts {
    stow -v fonts
}

function install_zsh {
    stow -v zsh
}

pushd "$install_path"

# call manually after source install.sh: install_userdirs