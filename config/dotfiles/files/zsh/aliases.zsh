# Quick shortcuts

alias anime='~/Singularis/local/scripts/anime'
alias yt='~/Singularis/local/scripts/youtube'

alias abook='abook --config "$XDG_CONFIG_HOME"/abook/abookrc --datafile "$XDG_DATA_HOME"/abook/addressbook'
alias mbsync='mbsync -c "${HOME}/.config/isync/mbsyncrc" -a'

alias b='bash'
alias c='calcurse'

alias minecraft='java -jar ~/Singularis/local/scripts/minecraft.jar'

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

alias r='ranger'
alias mkdir='mkdir --parents'

alias ks='killall sxhkd & sxhkd &'

alias python3='python3.7'
alias py='python3'

alias rm='rm -i'

alias n='ncmpcpp'

alias grep='grep --color'

# Checking for packages if they are installed
if command -v nvim &> /dev/null; then
  alias nv='nvim'
  alias nvv='nvim ~/.config/nvim/init.vim'
  alias nz='nvim ~/Singularis/aspects/dotfiles/files/.zshrc'
  alias nt='nvim ~/Singularis/aspects/dotfiles/files/.tmux.conf'
  alias nb='nvim ~/Singularis/aspects/dotfiles/files/.bashrc'
  alias nm='nvim ~/Singularis/aspects/dotfiles/files/.muttrc'
fi
if command -v vim &> /dev/null; then
  alias v='vim'
  alias vv='vim ~/.vimrc'
  alias vz='vim ~/Singularis/aspects/dotfiles/files/.zshrc'
  alias vt='vim ~/Singularis/aspects/dotfiles/files/.tmux.conf'
  alias vb='vim ~/Singularis/aspects/dotfiles/files/.bashrc'
  alias vm='vim ~/Singularis/aspects/dotfiles/files/.muttrc'
fi

if command -v neomutt &> /dev/null; then
  alias m='neomutt'
fi

if command -v pulsemixer &> /dev/null; then
  alias p='pulsemixer'
fi

# Directory listing/traversal

alias ls='exa --icons'
alias la='exa --icons --all'
alias l1='exa --icons -1'
alias ll='exa --icons -l'
alias lhi='exa --icons -l -i'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias ~='cd ~/'

alias ca='fasd -a'        # any
alias fs='fasd -si'       # show / search / select
alias fd='fasd -d'        # directory
alias ff='fasd -f'        # file
alias fsd='fasd -sid'     # interactive directory selection
alias fsf='fasd -sif'     # interactive file selection
alias fz='fasd_cd -d'     # cd, same functionality as j in autojump
alias fzz='fasd_cd -d -i' # cd with interactive selection
alias fv='f -e nvim' # quick opening files with vim
alias fm='f -e mpv' # quick opening files with mplayer
alias fo='a -e xdg-open' # quick opening files with xdg-open

