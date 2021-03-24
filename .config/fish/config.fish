fish_vi_key_bindings
set fish_greeting

alias ls 'ls -tr --color=auto'
alias .. 'cd ..'
alias ... 'cd ../..'
alias md 'mkdir -p'
alias sm 'GDK_BACKEND=wayland smerge .'
alias ssh 'TERM=xterm-256color command ssh'
alias sd 'sudo shutdown now'
alias c clear
alias usage 'sudo btrfs fi usage /'
alias za zathura

set PATH $PATH $HOME/bin $HOME/.cargo/bin $HOME/dotfiles/bin $HOME/vevo/rest $HOME/.local/bin

