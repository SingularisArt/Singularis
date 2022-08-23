function zle-keymap-select () {
  case $KEYMAP in
    printf '\033[1 q'
    printf '\033[6 q'
  esac
}
