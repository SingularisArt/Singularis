#!/usr/bin/bash

set -e
SESSION_NAME="System Configurations"

tmuxAttachCommand=""
if [ "$TMUX" != "" ]; then
  tmuxAttachCommand="tmux switch-client -t \"$SESSION_NAME:Dotfiles\""
else
  tmuxAttachCommand="tmux attach -t \"$SESSION_NAME:Dotfiles\""
fi

if tmux has-session -t "$SESSION_NAME" 2> /dev/null; then
  eval "$tmuxAttachCommand"
fi

tmux new-session -d -s "$SESSION_NAME"

tmux rename-window -t "$SESSION_NAME" "Dotfiles"
tmux send-keys -t "$SESSION_NAME" "cd ./aspects/dotfiles/files/; clear; lanc" Enter

tmux new-window -t "$SESSION_NAME"

tmux rename-window -t "$SESSION_NAME" "NeoVim"
tmux send-keys -t "$SESSION_NAME" "cd ./aspects/nvim/files/.config/nvim/; clear; lanc" Enter

tmux new-window -t "$SESSION_NAME"

tmux rename-window -t "$SESSION_NAME" "Email"
tmux send-keys -t "$SESSION_NAME" "cd ./aspects/email/files/.config; clear; lanc" Enter

tmux new-window -t "$SESSION_NAME"

tmux rename-window -t "$SESSION_NAME" "Git"
tmux send-keys -t "$SESSION_NAME" "watch git status" Enter

eval "$tmuxAttachCommand"
