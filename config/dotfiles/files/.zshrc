#  __  __           _____    _
# |  \/  |_   _    |__  /___| |__  _ __ ___
# | |\/| | | | |     / // __| '_ \| '__/ __|
# | |  | | |_| |  _ / /_\__ \ | | | | | (__
# |_|  |_|\__, | (_)____|___/_| |_|_|  \___|
#         |___/

cat ~/.cache/wal/sequences

source $HOME/.config/zsh/path # Must come first! (Others depend on it.)

source ~/.config/zsh/functions.zsh
# source ~/.github_token.zsh
source ~/Singularis/bin/common
source ~/Singularis/bin/variables

test -d $HOME/n && export N_PREFIX="$HOME/n"
typeset -A __SingularisArt

# Plugins
zsh_add_plugin "wting/autojump"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zshzoo/cd-ls"

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins

# Completions

# zsh_add_completion "github-username/github-repo"

# More completions https://github.com/zsh-users/zsh-completions

# Source zsh files
zsh_add_file "teh-h4xx.zsh"
zsh_add_file "global.zsh"
zsh_add_file "correction.zsh"
zsh_add_file "completions.zsh"
zsh_add_file "prompt.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "aliases.zsh"
zsh_add_file "options.zsh"
zsh_add_file "vim-mode.zsh"
zsh_add_file "exports.zsh"
zsh_add_file "bindings.zsh"
zsh_add_file "hooks.zsh"
zsh_add_file "icons.zsh"

neofetch
