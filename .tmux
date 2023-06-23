#!/usr/bin/bash

set -e
SESSION_NAME="Dotfiles"

if tmux has-session -t="$SESSION_NAME" 2> /dev/null; then
  tmux attach -t "$SESSION_NAME"
  exit
fi

tmux new-session -d -s "$SESSION_NAME"

tmux attach -t "$SESSION_NAME"
