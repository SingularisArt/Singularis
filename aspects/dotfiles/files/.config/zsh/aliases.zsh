#####################
#  Quick shortcuts  #
#####################

alias b='bash'
alias z='zsh'
alias c='clear'
alias minecraft='java -jar ~/.local/bin/minecraft.jar'
alias reloud='clear && source ~/.config/zsh/.zshrc'
alias l='lfub'
alias grep='grep --color'
alias mkdir='nocorrect mkdir --parents'
alias cp='nocorrect cp -iv'
alias mv='nocorrect mv -iv'
alias rm='nocorrect rm -vI'
alias myip='curl http://ipecho.net/plain; echo'
alias distro='source /etc/lsb-release && source /etc/os-release && echo "Main Distro: $ID_LIKE. Sub Distro: $DISTRIB_ID"'

if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
  alias update='sudo pacman -Syu'
  if command -v yay &> /dev/null; then
    alias updatey='yay -Syu'
  fi
fi

####################################
#  Aliases for installed programs  #
####################################

if command -v git &> /dev/null; then
  alias g='git'
  alias oo='git log --oneline'
  alias oos='git log --stat'
fi
if command -v yarn &> /dev/null; then
  alias yarn='yarn --use-yarnrc '$XDG_CONFIG_HOME/yarn/config''
fi
if command -v abook &> /dev/null; then
  alias abook='abook --config '$XDG_CONFIG_HOME'/abook/abookrc --datafile '$XDG_DATA_HOME'/abook/addressbook'
fi
if command -calcurse mariadb &> /dev/null; then
  alias c='calcurse'
fi
if command -v mariadb &> /dev/null; then
  alias ms='mariadb -u root -p'
fi
if command -v ncmpcpp &> /dev/null; then
  alias n='ncmpcpp'
fi
if command -v hugo &> /dev/null; then
  alias hss='hugo server --noHTTPCache'
  alias hssd='hugo server --noHTTPCache --buildDrafts'
fi
if command -v tmux &> /dev/null; then
  alias t='tmux'
  alias tn='tmux new-session'
  alias tl='tmux ls'
fi
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

#####################
#  Directory stuff  #
#####################

if command -v exa &> /dev/null; then
  alias ls='exa --icons'
  alias la='exa --icons --all'
  alias l1='exa --icons -1'
  alias ll='exa --icons -l'
  alias lhi='exa --icons -l -i'
else
  alias la='ls --color -a'
  alias l1='ls --color -1'
  alias ll='ls --color -l'
  alias lhi='ls --color -l -i'
fi

alias lsn='ls | wc -l'
alias lsnc='clear && ls && echo "" && echo "Current Number of Files: $(ls | wc -l)"'

alias lan='la | wc -l'
alias lanc='clear && la && echo "" && echo "Current Number of Files: $(ls -a | wc -l)"'

alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../..'
alias ...........='cd ../../../../../../../../../..'
alias -- -='cd -'
alias ~'cd ~/'
