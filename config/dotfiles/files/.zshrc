#  __  __           _____    _
# |  \/  |_   _    |__  /___| |__  _ __ ___
# | |\/| | | | |     / // __| '_ \| '__/ __|
# | |  | | |_| |  _ / /_\__ \ | | | | | (__
# |_|  |_|\__, | (_)____|___/_| |_|_|  \___|
#         |___/

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __SingularisArt

__SingularisArt[ITALIC_ON]=$'\e[3m'
__SingularisArt[ITALIC_OFF]=$'\e[23m'

cat $HOME/.cache/wal/sequences

source $HOME/.config/zsh/functions.zsh

# Plugins
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
zsh_add_plugin "wting/autojump"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Completions
# More completions https://github.com/zsh-users/zsh-completions

# zsh_add_completion "github-username/github-repo"

# Source zsh files
zsh_add_file "correction.zsh"
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

neofetch
