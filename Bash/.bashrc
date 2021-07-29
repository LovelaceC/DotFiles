# Exports
export PATH="${HOME}/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:"
export PATH="${PATH}/usr/local/sbin:/opt/bin:/usr/bin/core_perl:/usr/games/bin:"
export PATH="${PATH}:${HOME}/node_modules/netlify-cli/bin"

export EDITOR="emacs -nw"

# Aliases
alias ls="ls --color"
alias emacs="emacs -nw"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"

export PATH="/usr/lib/ccache/bin${PATH:+:}:${PATH}"
export CCACHE_DIR="/var/cache/ccache"
