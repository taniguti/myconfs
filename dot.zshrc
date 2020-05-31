# vim: set ts=4 sw=4 sts=0 et ft=sh fenc=utf-8 ff=unix :

autoload -Uz compinit && compinit

setopt auto_list
setopt auto_menu
setopt auto_cd

zstyle ':completion:*:default' menu select=1

export LANG=ja_JP.UTF-8

# History
HISTFILE="$HOME/.zsh-history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history

# HOMEBREW
# See also: https://github.com/drduh/macOS-Security-and-Privacy-Guide/issues/138
if [ -d "$HOME/homebrew" ]; then
    HOMEBREW_PREFIX="$HOME/homebrew"
    export HOMEBREW_PREFIX
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications --no-quarantine"
elif [ -d "$HOME/usr/local" ]; then
    HOMEBREW_PREFIX="$HOME/usr/local"
    export HOMEBREW_PREFIX
    export HOMEBREW_NO_ANALYTICS=1
#    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications"
else
    HOMEBREW_PREFIX=/nowhere
fi

# Command search pathes
setopt +o nomatch
cat .zshrc.d/paths /etc/paths.d/* /etc/paths 2> /dev/null \
 | grep -v ^#  \
 | awk NF \
 | while read -r CMDPATH
do
    if [ -d "$( eval echo "$CMDPATH" )" ]; then
        if [ -z "$CPATH" ]; then
            CPATH="$( eval echo "$CMDPATH" )"
        else
            CPATH="$CPATH":"$( eval echo "$CMDPATH" )"
        fi
    fi
done
setopt -o nomatch
export PATH="$CPATH"
typeset -gU PATH

if [ -f "$HOME/.git-completion.zsh" ] && [ "$( command -v git)" ]; then
    source "$HOME/.git-completion.zsh"
fi

#if [ -f "$HOMEBREW_PREFIX/completions/zsh/brew" ]; then
#    source "$HOMEBREW_PREFIX/completions/zsh/brew"
#elif [ -f /usr/local/Homebrew/completions/zsh/brew ]; then
#    source /usr/local/Homebrew/completions/zsh/brew
#fi
#if [ -f "${HOMEBREW_PREFIX}/etc/zsh_completion" ]; then
#    source "${HOMEBREW_PREFIX}/etc/zsh_completion"
#elif [ -f "/usr/local/etc/zsh_completion" ]; then
#    source "/usr/local/etc/zsh_completion"
#fi

# Command aliases
if [ -f "$HOME/.zsh_aliases" ]; then . "$HOME/.zsh_aliases" ; fi

# Show system info
if [ -f "$HOME/.systeminfo" ]; then . "$HOME/.systeminfo" ; fi
