# Quick shortcuts

alias abook='abook --config '$XDG_CONFIG_HOME'/abook/abookrc --datafile '$XDG_DATA_HOME'/abook/addressbook'
alias mbsync='mbsync -c '${HOME}/.config/isync/mbsyncrc' -a'

alias b='bash'
alias c='calcurse'

alias minecraft='java -jar minecraft.jar'

alias reloud='clear && source ~/.config/zsh/.zshrc'
alias ms='mysql -u root -p'

alias t='tmux'
alias tn='tmux new-session'
alias tl='tmux ls'

alias e='exit'
alias h='htop'

alias g='git'
alias oo='git log --oneline'
alias oos='git log --stat'

alias l='lfub'

alias ks='killall sxhkd & sxhkd &'

alias n='ncmpcpp'

alias grep='grep --color'

alias yarn='yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config''

alias mkdir='nocorrect mkdir --parents'
alias cp='nocorrect cp -iv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -vI'
alias bc='nocorrect bc -ql'

alias hss='hugo server --noHTTPCache'
alias hssd='hugo server --noHTTPCache --buildDrafts'

# Checking for packages if they are installed
if command -v nvim &> /dev/null; then
  alias nv='nvim'
fi

if command -v dvim &> /dev/null; then
  alias dv='dvim'
fi

if command -v lvim &> /dev/null; then
  alias lv='lvim'
fi

if command -v neomutt &> /dev/null; then
  alias m='neomutt'
fi

if command -v pulsemixer &> /dev/null; then
  alias p='pulsemixer'
fi

# Directory listing/traversal

if command -v exa &> /dev/null; then
  alias ls='exa --icons'
  alias la='exa --icons --all'
  alias l1='exa --icons -1'
  alias ll='exa --icons -l'
  alias lhi='exa --icons -l -i'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias ~='cd ~/'
