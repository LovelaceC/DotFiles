# Colours
darkgrey="$(tput bold ; tput setaf 0)"
white="$(tput bold ; tput setaf 7)"
blue="$(tput bold; tput setaf 4)"
cyan="$(tput bold; tput setaf 6)"
nc="$(tput sgr0)"

# Exports
export PATH="${HOME}/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:"
export PATH="${PATH}/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:"
export PATH="${PATH}:${HOME}/.gem/ruby/3.0.0/bin"


if [[ $EUID -eq 0 ]]; then
    export PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$darkgrey\]# \[$nc\]"
else
    export PS1="\[$blue\][ \[$cyan\]\H \[$darkgrey\]\w\[$darkgrey\] \[$blue\]]\\[$cyan\]\$ \[$nc\]"
fi

export LD_PRELOAD=""
export EDITOR="emacs -nw"

# Aliases
alias ls="ls --color"
alias emacs="emacs -nw"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"
