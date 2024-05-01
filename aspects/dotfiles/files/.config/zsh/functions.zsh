################################################################################
#                                                                              #
#                                 Git Wrapper                                  #
#                                                                              #
################################################################################
#
# - `git` with no arguments = `git status`; run `git help` to show what
#   vanilla `git` without arguments would normally show..
# - `git root` = `cd` to repo root.
# - `git root ARG...` = evals `ARG...` from the root (eg. `git root ls`).
# - `git ARG...` = behaves just like normal `git` command.
#
function git() {
  if [ $# -eq 0 ]; then
    command git status
  elif [ "$1" = root ] || [ "$1" = r ]; then
    cd $(git get-root) || exit
    shift
    if [ $# -gt 0 ]; then
      command git "$@"
    fi
  else
    command git "$@"
  fi
}

################################################################################
#                                                                              #
#                                    Email                                     #
#                                                                              #
################################################################################
function email() {
  emulate -L zsh

  if ! tmux has-session -t email 2> /dev/null; then
    # Make saved attachments go to ~/Downloads by default.
    tmux new-session -d -s email -c ~/Downloads -n mutt
    tmux send-keys -t email:mutt mutt Enter
    tmux new-window -t email -c ~/.mutt -n sync
    tmux send-keys -t email:sync '~/.mutt/scripts/control.sh --daemon' Enter
    tmux split-window -t email:sync -v -f -l 8 -c ~/.mutt
    tmux send-keys -t email:sync.bottom '~/.mutt/scripts/control.sh' Enter
  fi
  if [ -z "$TMUX" ]; then
    tmux attach -t email:mutt
  else
    tmux switch-client -t email:mutt
  fi
}


################################################################################
#                                                                              #
#                                   Scratch                                    #
#                                                                              #
################################################################################
#
# - Create a temporary folder in /tmp/.
# - Create a new zsh shell.
# - Cd into it.
# - Echo some information.
#
function scratch() {
  local SCRATCH=$(mktemp -d)
  echo 'Spawing subshell in scratch directory:'
  echo "  $SCRATCH"
  (cd $SCRATCH; zsh)
  echo "Removing scratch directory"
  rm -rf "$SCRATCH"
}


################################################################################
#                                                                              #
#                                     Tmux                                     #
#                                                                              #
################################################################################
#
# - If there's a .tmux file within the current directory and it's a file, then
#   it performs the following:
#     - If the file is exeuctable, it'll ask for your permission to run tmux
#       with that .tmux file by giving you a sha512sum and make sure that's the
#       file you wish to run.
#     - You can press 't', and it'll run it.
#     - It'll remember that you allowed it to run that file because it stores
#       all the files sha512sum that you allow in ~/.config/tmux/tmux.digests.
#  - If there isn't a file, it'll open a new tmux session with the name of the
#    current directory. If there's a session already created with that name,
#    it'll just open that session up.
#
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
      if ! grep -q "$DIGEST" ~/.config/tmux/tmux.digests 2> /dev/null; then
        cat .tmux
        read -k 1 -r \
          'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
        if [[ $REPLY =~ ^[Tt]$ ]]; then
          echo "$DIGEST" >> ~/.config/tmux/tmux.digests
          ./.tmux
          return
        fi
      else
        ./.tmux
        return
        echo ""
      fi
    fi
  fi

  # Attach to existing session, or create one, based on current directory.
  local SESSION_NAME=$(basename "${$(pwd)}")
  env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
}


#######################################################################
#                                                                     #
#                           Pomodoro Timer                            #
#                                                                     #
#######################################################################

# https://gist.github.com/bashbunni/3880e4194e3f800c4c494de286ebc1d7
declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}
