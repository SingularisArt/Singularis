# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __SingularisArt

__SingularisArt[ITALIC_ON]=$'\e[3m'
__SingularisArt[ITALIC_OFF]=$'\e[23m'

function zap_config() {
  source ~/.local/share/zap/zap.zsh

  zapplug "$HOME/.config/zsh/aliases.zsh"
  zapplug "$HOME/.config/zsh/aliases.zsh"
  zapplug "$HOME/.config/zsh/aliases.zsh"
  zapplug "$HOME/.config/zsh/aliases.zsh"

# Example install plugins
zapplug "zap-zsh/supercharge"
zapplug "zsh-users/zsh-autosuggestions"
zapplug "zsh-users/zsh-syntax-highlighting"
zapplug "hlissner/zsh-autopair"
zapplug "zap-zsh/vim"

# Example theme
zapplug "zap-zsh/singularisart-prompt"

# Example install completion
zapplug "esc/conda-zsh-completion"
}

function personal_config() {
  source $ZDOTDIR/functions.zsh
  source $ZDOTDIR/plugins.zsh

  # Plugins
  # For more plugins: https://github.com/unixorn/awesome-zsh-plugins
  zsh_add_plugin "zsh-users/zsh-autosuggestions"
  zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
  zsh_add_plugin "zsh-users/zsh-history-substring-search"
  # zsh_add_plugin "hlissner/zsh-autopair"

  # Completions
  # More completions https://github.com/zsh-users/zsh-completions
  # zsh_add_completion "esc/conda-zsh-completion"

  # Source zsh files
  zsh_add_file "completions.zsh"
  zsh_add_file "hooks.zsh"
  zsh_add_file "prompt.zsh"
  zsh_add_file "exports.zsh"
  zsh_add_file "aliases.zsh"
  zsh_add_file "options.zsh"
  zsh_add_file "vim-mode.zsh"
  zsh_add_file "icons.zsh"
  zsh_add_file "autojump.zsh"
  zsh_add_file "bindings.zsh"
  # zsh_add_file "tmux.zsh"
}


personal_config
