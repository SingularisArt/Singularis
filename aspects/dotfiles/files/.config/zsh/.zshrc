# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __SingularisArt

__SingularisArt[ITALIC_ON]=$'\e[3m'
__SingularisArt[ITALIC_OFF]=$'\e[23m'

source $ZDOTDIR/functions.zsh
source $ZDOTDIR/plugins.zsh

# opam_file_location="$HOME/.local/share/opam/opam-init/init.zsh"
# [[ ! -r "$opam_file_location" ]] || source "$opam_file_location"  > /dev/null 2> /dev/null

#############
#  Plugins  #
#############

# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# zsh_add_plugin "jeffreytse/zsh-vi-mode"  # Wait until bug fix: https://github.com/jeffreytse/zsh-vi-mode/issues/199
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"
# zsh_add_plugin "SingularisArt/docker-completion"
# zsh_add_plugin "hlissner/zsh-autopair"

[[ ! -r "/home/singularisart/.local/share/opam/opam-init/init.zsh" ]] || source "/home/singularisart/.local/share/opam/opam-init/init.zsh" > /dev/null 2> /dev/null

#################
#  Completions  #
#################

# More completions https://github.com/zsh-users/zsh-completions
# zsh_add_completion "esc/conda-zsh-completion"

######################
#  Custom ZSH Files  #
######################

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
