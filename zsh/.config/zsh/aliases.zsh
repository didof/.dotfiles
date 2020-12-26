#!/usr/bin/env zsh

# For a full list of active aliases, run `alias`.

alias top="sudo htop"

# alias CAT to BAT iff it exists
if (( $+commands[bat] )); then
    alias cat='bat'
fi

# alias ls to exa iff it exists
if (( $+commands[exa] )); then
    alias ls='exa'
fi

alias l='exa -lah --git'