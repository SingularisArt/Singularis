# Until .agrc exists...
# (https://github.com/ggreer/the_silver_searcher/pull/709)
function ag() {
  emulate -L zsh

  # italic blue paths, pink line numbers, underlined purple matches
  command ag --pager="less -iFMRSX" --color-path=34\;3 --color-line-number=35 --color-match=35\;1\;4 "$@"
}

# Append $1 to $PATH, unless already present.
# If present, moves it to the end.
# See also: prepend_path().
function append_path() {
  PATH=${PATH//":$1:"/:} # Delete (potentially multiple) from middle.
  PATH=${PATH/#"$1:"/} # Delete from start.
  PATH=${PATH/%":$1"/} # Delete from end.
  PATH="${PATH:+$PATH:}$1" # Actually append (or if PATH is empty, just set).
}

# fd - "find directory"
# Inspired by: https://github.com/junegunn/fzf/wiki/examples#changing-directory
function fd() {
  local DIR
  DIR=$(bfs -type d 2> /dev/null | sk --no-multi --preview='test -n "{}" && ls {}' -q "$*") && cd "$DIR"
}

# fh - "find [in] history"
# Inspired by: https://github.com/junegunn/fzf/wiki/examples#command-history
function fh() {
  print -z $(fc -l 1 | sk --no-multi --tac -q "$*" | sed 's/ *[0-9]*\*\{0,1\} *//')
}

# TODO: decide whether this is a reasonable idea
function files() {
  find "$@" | xargs -o $EDITOR
}

# `git` wrapper:
#
#     - `git` with no arguments = `git status`; run `git help` to show what
#     - `git st` = `git status`;
#     - `git l` = `git log`;
#     - `git a` = `git add`;
#     - `git c` = `git commit`;
#     - `git p` = `git push`;
#     - `git chk` = `git checkout`;
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
  elif [ "$1" = st ]; then
    command git status
  elif [ "$1" = co ]; then
    command git checkout "$2"
  elif [ "$1" = l ]; then
    command git log
  elif [ "$1" = b ]; then
    command git branch
  elif [ "$1" = a ]; then
    if [ -z "$2" ]; then
      command git add .
    else
      command git add $2
    fi
  elif [ "$1" = c ]; then
    if [ -z "$2" ]; then
      command git commit -S
    else
      command git commit -S -m $2
    fi
  elif [ "$1" = p ]; then
    if [ -z "$2" ]; then
      command git push
    else
      command git push $2
    fi
  else
    command git "$@"
  fi
}

# Print headers, following redirects.
# Based on: https://stackoverflow.com/a/10060342/2103996
function headers() {
  emulate -L zsh

  if [ $# -ne 1 ]; then
    echo "error: a host argument is required"
    return 1
  fi

  local REMOTE=$1

  curl -sSL -D - "$REMOTE" -o /dev/null
}

function history() {
  emulate -L zsh

  # This is a function because Zsh aliases can't take arguments.
  fc -l 1
}

function mvim() {
  emulate -L zsh

  # Makes user-installed fonts visible to MacVim.
  if which reattach-to-user-namespace &> /dev/null ; then
    reattach-to-user-namespace mvim
  else
    command mvim
  fi
}

# Prepend $1 to $PATH, unless already present.
# If present, moves it to the start.
# See also: append_path().
function prepend_path() {
  PATH=${PATH//":$1:"/:} # Delete (potentially multiple) from middle.
  PATH=${PATH/#"$1:"/} # Delete from start.
  PATH=${PATH/%":$1"/} # Delete from end.
  PATH="$1${PATH:+:$PATH}$1" # Actually prepend (or if PATH is empty, just set).
}

function scratch() {
  local SCRATCH=$(mktemp -d)
  echo 'Spawing subshell in scratch directory:'
  echo "  $SCRATCH"
  (cd $SCRATCH; zsh)
  echo "Removing scratch directory"
  rm -rf "$SCRATCH"
}

# Print information about a remote SSL certificate.
# Based on: https://serverfault.com/a/661982/219567
function ssl() {
  emulate -L zsh

  if [ $# -ne 1 ]; then
    echo "error: a host argument is required"
    return 1
  fi

  local REMOTE=$1

  echo | openssl s_client -showcerts -servername "$REMOTE" -connect "$REMOTE:443" 2>/dev/null | openssl x509 -inform pem -noout -text
}

# Bounce the Dock icon, if iTerm does not have focus.
function bounce() {
  if [ -n "$TMUX" ]; then
    print -Pn "\ePtmux;\e\e]1337;RequestAttention=1\a\e\\"
  else
    print -Pn "\e]1337;RequestAttention=1\a"
  fi
}

# regmv = regex + mv (mv with regex parameter specification)
#   example: regmv '/\.tif$/.tiff/' *
#   replaces .tif with .tiff for all files in current dir
#   must quote the regex otherwise "\." becomes "."
# limitations: ? doesn't seem to work in the regex, nor *
function regmv() {
  emulate -L zsh

  if [ $# -lt 2 ]; then
    echo "  Usage: regmv 'regex' file(s)"
    echo "  Where:       'regex' should be of the format '/find/replace/'"
    echo "Example: regmv '/\.tif\$/.tiff/' *"
    echo "   Note: Must quote/escape the regex otherwise \"\.\" becomes \".\""
    return 1
  fi
  local REGEX="$1"
  shift
  while [ -n "$1" ]
  do
    local NEWNAME=$(echo "$1" | sed "s${REGEX}g")
    if [ "${NEWNAME}" != "$1" ]; then
      mv -i -v "$1" "$NEWNAME"
    fi
    shift
  done
}

function _jump_complete() {
  emulate -L zsh

  local COMPLETIONS
  COMPLETIONS="$(hash -d|cut -d= -f1)"
  reply=( "${(ps:\n:)COMPLETIONS}" )
}

# Complete filenames and `hash -d` entries.
compctl -f -K _jump_complete jump

# Print a pruned version of a tree.
#
# Examples:
#
#   # Print all "*.js" files in src:
#   subtree '*.js' src
#
#   # Print all "*.js" files in the current directory:
#   subtree '*.js'
#
#   # Print all "*.js" and "*.ts" files in current directory:
#   subtree '*.js|*.ts'
#
function subtree() {
  tree -a --prune -P "$@"
}

function swallow() {
  local ARGS=$*
  local ID=$(xdo id)
  xdo hide
  eval "$*" &> /dev/null
  xdo show "$ID"
}

# "[t]ime[w]arp" by setting GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.
function tw() {
  emulate -L zsh

  local TS=$(ts "$@")
  echo "Spawning subshell with timestamp: $TS"
  env GIT_AUTHOR_DATE="$TS" GIT_COMMITTER_DATE="$TS" zsh
}

# "tick" by incrementing GIT_AUTHOR_DATE and GIT_COMMITTER_DATE.
function tick() {
  emulate -L zsh

  if [ -z "$GIT_AUTHOR_DATE" -o -z "$GIT_COMMITTER_DATE" ]; then
    echo 'Expected $GIT_AUTHOR_DATE and $GIT_COMMITTER_DATE to be set.'
    echo 'Did you forget to timewarp with `tw`?'
  else
    # Fragile assumption: dates are in format produced by `tw`/`ts`.
    local TS=$(expr \
      $(echo $GIT_AUTHOR_DATE | cut -d ' ' -f 1) \
      $(parseoffset "$@") \
    )
    local TZ=$(date +%z)
    echo "Bumping timestamp to: $TS $TZ"
    export GIT_AUTHOR_DATE="$TS $TZ"
    export GIT_COMMITTER_DATE="$TS $TZ"
  fi
}

function compile() {
  if [[ -e "${1}.tex" ]]; then
    pdflatex ${1}.tex
    pdflatex ${1}.tex
    pdflatex ${1}.tex
    pdflatex ${1}.tex
    mv ${1}.tex ${1}.pdf ..
    rm -rf ${1}*
    mv ../${1}.tex ../${1}.pdf .
    zathura ${1}.pdf
  else
    echo "No file named ${1}.tex found."
  fi
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

# Bounce the Dock icon, if iTerm does not have focus.
function bounce() {
  if [ -n "$ITERM_SESSION_ID" ]; then
    if [ -n "$TMUX" ]; then
      print -Pn "\ePtmux;\e\e]1337;RequestAttention=1\a\e\\"
    else
      print -Pn "\e]1337;RequestAttention=1\a"
    fi
  fi
}

# Bounce the Dock icon, if iTerm does not have focus.
function bounce() {
  if [ -n "$TMUX" ]; then
    print -Pn "\ePtmux;\e\e]1337;RequestAttention=1\a\e\\"
  else
    print -Pn "\e]1337;RequestAttention=1\a"
  fi
}

# regmv = regex + mv (mv with regex parameter specification)
#   example: regmv '/\.tif$/.tiff/' *
#   replaces .tif with .tiff for all files in current dir
#   must quote the regex otherwise "\." becomes "."
# limitations: ? doesn't seem to work in the regex, nor *
function regmv() {
  emulate -L zsh

  if [ $# -lt 2 ]; then
    echo "  Usage: regmv 'regex' file(s)"
    echo "  Where:       'regex' should be of the format '/find/replace/'"
    echo "Example: regmv '/\.tif\$/.tiff/' *"
    echo "   Note: Must quote/escape the regex otherwise \"\.\" becomes \".\""
    return 1
  fi
  local REGEX="$1"
  shift
  while [ -n "$1" ]
  do
    local NEWNAME=$(echo "$1" | sed "s${REGEX}g")
    if [ "${NEWNAME}" != "$1" ]; then
      mv -i -v "$1" "$NEWNAME"
    fi
    shift
  done
}

function build_cscope_db_func() {
  local PROJDIR=$PWD
  cd /
  find $PROJDIR -name \\''*.c\\'' -o -name \\''*.h\\'' > $PROJDIR/cscope.files
  cd $PROJDIR
  cscope -Rbkq
}

function ctags() {
  if [ "$1" = . ]; then
    command ctags -R .
  else
    command ctags "$@"
  fi
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
