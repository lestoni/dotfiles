# Verbose file linking.
alias ln='ln -v'

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Lock the screen when AFK
alias afk="gnome-screensaver-command -l"

# list only dotfiles
alias dotfiles='ls -a | grep "^\."'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# easier navigation
alias home="cd ~"
alias up="cd ../"
alias prev="cd -"

# shorcuts
alias dls="cd ~/Downloads"
alias jets="cd ~/projects"
alias docs="cd ~/Documents"
alias src="cd ~/projects/source"

# tools
alias chrome="google-chrome-stable"
alias tmux="tmux -2"
alias gget="go get"
alias vi="vim"

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Gzip-enabled `curl`
alias gurl="curl --compressed"

# Easier copy/paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# vhosts
alias hosts="sudo $EDITOR /etc/hosts"

# Copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# copy file interactive
alias cp='cp -i'

# move file interactive
alias mv='mv -i'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_rsa | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"
