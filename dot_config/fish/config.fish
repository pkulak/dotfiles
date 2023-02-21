fish_vi_key_bindings
set fish_greeting

alias ls 'ls -tr --color=auto'
alias .. 'cd ..'
alias ... 'cd ../..'
alias md 'mkdir -p'
alias sm 'GDK_BACKEND=wayland smerge .'
alias ssh 'TERM=xterm-256color command ssh'
alias c clear
alias za zathura
alias ts 'date -u +"%Y-%m-%dT%H:%M:%SZ"'
alias l 'exa --long --all --links --git --sort mod'
alias bc 'bc -lq'
alias rs 'rsync -avH --info=progress2'
alias dr 'dragon-drop -a -x'

alias mntvevo 'gocryptfs ~/Drive/crypt/vevo ~/vevo/Notes'
alias mntprivate 'gocryptfs ~/Drive/crypt/private ~/private'

set PATH $PATH $HOME/bin $HOME/.cargo/bin $HOME/dotfiles/bin $HOME/vevo/rest/bin $HOME/.local/bin
