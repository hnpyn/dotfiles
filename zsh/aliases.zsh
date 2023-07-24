# aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias zshconfig="mate ~/.zshrc"
alias vi="nvim"
alias vim="nvim"
alias ra="ranger"
alias lg="lazygit"
alias nf="neofetch"
alias icat="kitty +kitten icat"
alias chrome="google-chrome"
alias pigcha="PigchaProxy"
