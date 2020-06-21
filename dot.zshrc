# vim: set ts=4 sw=4 sts=0 et ft=sh fenc=utf-8 ff=unix :

autoload -Uz compinit && compinit
autoload -Uz zmv

setopt auto_list
setopt auto_menu
setopt auto_cd

zstyle ':completion:*:default' menu select=1

export LANG=ja_JP.UTF-8

# HOMEBREW
# See also: https://github.com/drduh/macOS-Security-and-Privacy-Guide/issues/138
if [ -x /usr/local/bin/brew ] ; then
    brewInstalled=yes
    export HOMEBREW_PREFIX="/usr/local"
elif [ -x "$HOME/homebrew/bin/brew" ]; then
    brewInstalled=yes
    export HOMEBREW_PREFIX="$HOME/homebrew"
elif [ -x "$HOME/usr/local/bin/brew" ]; then
    brewInstalled=yes
    export HOMEBREW_PREFIX="$HOME/usr/local"
else
    brewInstalled=no
    export HOMEBREW_PREFIX=/nowhere
fi

if [ "$brewInstalled" = yes ]; then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications --no-quarantine"
fi

if [ -d "${HOMEBREW_PREFIX}/opt/zplug" ]; then
    zplugInstalled=yes
    export ZPLUG_HOME="${HOMEBREW_PREFIX}/opt/zplug"
fi

# Command search pathes
setopt +o nomatch
cat "${HOME}/.zshrc.d/paths" /etc/paths.d/* /etc/paths 2> /dev/null \
 | grep -v ^# \
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

if [ -f "$HOME/.zsh/git-completion.zsh" ] && [ "$( command -v git)" ]; then
    zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
    fpath=(~/.zsh $fpath)
    autoload -Uz compinit && compinit
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

# Additional rcs
for zrc in "${HOME}/.zshrc.d/aliases" \
           "${ZPLUG_HOME}/init.zsh"
do
    if [ -f "$zrc" ]; then . "$zrc" ; fi
done

if [ "${zplugInstalled:-no}" = yes ]; then
    zplug "modules/history", from:prezto
    zplug "modules/directory", from:prezto
    if [ "$( uname -s )" = Darwin ]; then
        zplug "modules/osx", from:prezto
    fi

    if ! zplug check --verbose; then zplug install; fi
    zplug load
else
    # History
    setopt share_history
fi

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
