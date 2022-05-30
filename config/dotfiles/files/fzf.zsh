# Setup fzf
# ---------
if [[ ! "$PATH" == */home/hashem/Singularis/third-party-tools/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/hashem/Singularis/third-party-tools/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/hashem/Singularis/third-party-tools/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/hashem/Singularis/third-party-tools/fzf/shell/key-bindings.zsh"
