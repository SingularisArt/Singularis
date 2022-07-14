#!/usr/bin/env bash

# Set Session Name
SESSION="dot"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]; then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    # Name first Pane and start zsh
    tmux rename-window -t 1 'nvim'
    tmux send-keys -t 'nvim' 'dvim' C-m # Switch to bind script?

    # Setup an additional shell
    tmux new-window -t $SESSION:2 -n 'zsh'
    tmux split-window -v
    tmux send-keys -t 'zsh' 'bashtop' C-m # Switch to bind script?

    # Setup a pane for git
    tmux new-window -t $SESSION:3 -n 'git'
    tmux split-window -h
    tmux send-keys -t 'git' 'lazygit' C-m # Switch to bind script?
fi

# Attach Session, on the Main window
tmux a -t $SESSION:1

