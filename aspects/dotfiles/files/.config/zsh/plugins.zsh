__SingularisArt[PLUGIN_DIR]=third-party/plugins
__SingularisArt[COMPLETION_DIR]=third-party/completions

function zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  PLUGIN_PATH="$ZDOTDIR/${__SingularisArt[PLUGIN_DIR]}/$PLUGIN_NAME"

  if [ ! -d "$PLUGIN_PATH" ]; then
    git clone "https://github.com/$1.git" "$PLUGIN_PATH"
  fi

  source "$PLUGIN_PATH/$PLUGIN_NAME.plugin.zsh" || \
  source "$PLUGIN_PATH/$PLUGIN_NAME.zsh"
}

function zsh_add_completion() {
  COMPLETION_NAME=$(echo $1 | cut -d "/" -f 2)
  COMPLETION_PATH="$ZDOTDIR/$__SingularisArt[COMPLETION_DIR]/$COMPLETION_NAME"

  if [ ! -d "$COMPLETION_PATH" ]; then
    git clone "https://github.com/$1.git" "$__SingularisArt[COMPLETION_DIR]/$COMPLETION_NAME"
  fi

  fpath+="$(dirname "${completion_file_path}")"
  source "$COMPLETION_PATH/$COMPLETION_NAME.plugin.zsh"
  completion_file="$(basename "${completion_file_path}")"

  if [ "$2" = true ] && compinit "$completion_file:1"
}
