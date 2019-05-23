# Add bin to path
export PATH="$PATH:$HOME/bin"

# Dynamic resizing
shopt -s checkwinsize

# Custom prompt
if [ $(id -u) -eq 0 ];
then
    PS1='\[\e[1;36m\][\u@\h \w]\$\[\e[m\] '
else
    PS1='\[\e[1;33m\][\u@\h \w]\$\[\e[m\] '
fi

# Add color
eval `dircolors -b`

# User defined aliases
alias cls='clear'
alias clls='clear; ls'
alias ls='ls --color=auto'
alias ll='ls -l'
alias lsa='ls -A'
alias lsg='ls | grep'
alias vi='vim'

echo "add-auto-load-safe-path $(pwd)/.gdbinit" > ${HOME}/.gdbinit

alias gdb='gdb -x .gdbinit'

clear
