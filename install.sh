#!/usr/bin/env bash

if ! [ -x /usr/bin/stow ]; then
  echo "error: stow is not installed" 
  echo "to fix this, run: sudo apt install stow"
  exit 1
fi

stow -vt $HOME tmux
stow -vt $HOME config
stow -vt $HOME user_scripts
stow -vt $HOME kadevrc
