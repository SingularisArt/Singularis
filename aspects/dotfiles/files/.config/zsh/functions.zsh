# `git` wrapper:
#
#     - `git` with no arguments = `git status`; run `git help` to show what
#       vanilla `git` without arguments would normally show.
#     - `git root` = `cd` to repo root.
#     - `git root ARG...` = evals `ARG...` from the root (eg. `git root ls`).
#     - `git ARG...` = behaves just like normal `git` command.
#
function git() {
  if [ $# -eq 0 ]; then
    command git status
  elif [ "$1" = root ] || [ "$1" = r ]; then
    shift
    local ROOT
    if [ "$(command git rev-parse --is-inside-git-dir 2> /dev/null)" = true ]; then
      if [ "$(command git rev-parse --is-bare-repository)" = true ]; then
        ROOT="$(command git rev-parse --absolute-git-dir)"
      else
        # Note: This is a good-enough, rough heuristic, which ignores
        # the possibility that GIT_DIR might be outside of the worktree;
        # see:
        # https://stackoverflow.com/a/38852055/2103996
        ROOT="$(command git rev-parse --git-dir)/.."
      fi
    else
      # Git 2.13.0 and above:
      ROOT="$(command git rev-parse --show-superproject-working-tree 2> /dev/null)"
      if [ -z "$ROOT" ]; then
        ROOT="$(command git rev-parse --show-toplevel 2> /dev/null)"
      fi
    fi
    if [ -z "$ROOT" ]; then
      ROOT=.
    fi
    if [ $# -eq 0 ]; then
      cd "$ROOT"
    else
      (cd "$ROOT" && eval "$@")
    fi
  fi
}

function scratch() {
  local SCRATCH=$(mktemp -d)
  echo 'Spawing subshell in scratch directory:'
  echo "  $SCRATCH"
  (cd $SCRATCH; zsh)
  echo "Removing scratch directory"
  rm -rf "$SCRATCH"
}

function tmux() {
  emulate -L zsh

  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK.
  # (Inspired by: https://gist.github.com/lann/6771001)
  local SOCK_SYMLINK=~/.ssh/ssh_auth_sock
  if [ -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" $SOCK_SYMLINK
  fi

  # If provided with args, pass them through.
  if [[ -n "$@" ]]; then
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$@"
    return
  fi

  # Check if a .tmux file exists
  if [[ -f .tmux ]]; then
    # Check if the file is an executable
    if [[ -x .tmux ]]; then
      # Prompt the first time we see a given .tmux file before running it.
      local DIGEST="$(openssl sha512 .tmux)"
      if ! grep -q "$DIGEST" ~/..tmux.digests 2> /dev/null; then
        cat .tmux
        read -k 1 -r \
          'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
        if [[ $REPLY =~ ^[Tt]$ ]]; then
          echo "$DIGEST" >> ~/..tmux.digests
          ./.tmux
          return
        fi
      else
        ./.tmux
        return
        echo ""
      fi
    # If the file isn't an executable, ask the user if they would still like to
    # run it
    else
      read -k 1 -r \
        'REPLY?.tmux file found, but not executable. (m = make executable, otherwise = skip) '
      if [[ $REPLY =~ ^[Mm]$ ]]; then
        chmod +x .tmux
        local DIGEST="$(openssl sha512 .tmux)"
        echo "$DIGEST" >> ~/..tmux.digests
        ./.tmux
        return
      fi
    fi
  fi

  # Attach to existing session, or create one, based on current directory.
  local SESSION_NAME=$(basename "${$(pwd)}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}

function gpg() {
  if [ "$1" = "" ]; then
    command gpg --list-keys
  else
    command gpg "$@"
  fi
}

# Function to source files if they exist
ZDOTDIR=~/.config/zsh
function zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

PLUGIN_DIR=~/.config/zsh/plugins
function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$PLUGIN_DIR/$PLUGIN_NAME" ]; then
    # For plugins
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$PLUGIN_DIR/$PLUGIN_NAME"
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  fi
}

COMPLETION_DIR=~/.config/zsh/completions
function zsh_add_completion() {
  COMPLETION_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$COMPLETION_DIR/$COMPLETION_NAME" ]; then
    # For completions
    completion_file_path=$(ls $COMPLETION_DIR/$COMPLETION_NAME/_*)
    fpath+="$(dirname "${completion_file_path}")"
    zsh_add_file "completions/$COMPLETION_NAME/$COMPLETION_NAME.plugin.zsh"
  else
    git clone "https://github.com/$1.git" "$COMPLETION_DIR/$COMPLETION_NAME"
    fpath+="$(ls $COMPLETION_DIR/$COMPLETION_NAME/_*)"
  fi
  completion_file="$(basename "${completion_file_path}")"
  if [ "$2" = true ] && compinit "$completion_file:1"
}
