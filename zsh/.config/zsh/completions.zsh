#!/usr/bin/env zsh

# The following lines were added by compinstall
zstyle :compinstall filename '/home/didof/.zshrc'

autoload -Uz compinit
compinit

# todo > wrap into an if on plugins array (contains docker plugin?)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes