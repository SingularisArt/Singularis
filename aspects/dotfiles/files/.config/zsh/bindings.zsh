# Go up one command history.
bindkey '^k' vi-up-line-or-history

# Go down one command history.
bindkey '^j' vi-down-line-or-history

# Go forward a character.
bindkey -M vicmd 'k' history-substring-search-up

# Go down one command history.
bindkey -M vicmd 'j' history-substring-search-down

# Accept autosuggestion from zsh-autosuggestion.
bindkey '^ ' autosuggest-accept

# Fixes a bug that happens when I leave and come back in insert mode, I can't
# remove anything.
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e.
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Resource zsh config when pressing ctrl-r.
bindkey -s '^r' '^usource ~/.config/zsh/.zshrc\n'

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# Use lf to switch directories and bind it to ctrl-o.
lfcd () {
  tmp="$(mktemp)"
  lfub -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp" >/dev/null
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^o' '^ulfcd^M'
