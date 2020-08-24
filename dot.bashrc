#
# dot.bashrc
#

# Path check function ##########################
chck_path(){
    for i in $@; do
        case ${FOUND_PATH:-NULL} in
        NULL)
            if [ -d "$i" ]; then FOUND_PATH="$i"; fi
            ;;
        *)
            if [ -d "$i" ]; then FOUND_PATH="$FOUND_PATH:$i"; fi
            ;;
        esac
    done
    echo $FOUND_PATH
}

#+++ Basic Settings +++
ME=`whoami`
HOSTNAME=`hostname -s`

# information is shown in K-Blocks
BLOCKSIZE=K; export BLOCKSIZE
# PROMPT
PS1="\u@\h:\W/[\!]$ "
# Editor
EDITOR=vi; export EDITOR

# HISTORY
if [ "${HISTTIMEFORMAT:-X}" = X ]; then
    HISTTIMEFORMAT='%Y-%m-%dT%T%z '; export HISTTIMEFORMAT
fi

if [ ${HISTSIZE:-10000} -le 100000 ]; then
    HISTSIZE=100000; export HISTSIZE
    HISTFILESIZE=100000; export HISTFILESIZE
fi

# HISTCONTROL=ignoreboth; export HISTCONTROL
if [ ${TERM_PROGRAM:-X} != Apple_Terminal ]; then

    share_history() {
        history -a
        history -c
        history -r
    }

    case "$PROMPT_COMMAND" in
        *share_history*)
            : nothing
            ;;
        *)
            PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND};} share_history"
            export PROMPT_COMMAND
            ;;
    esac

    shopt -u histappend

    if [ ! -s "$HOME/.bash_history" ]; then
        echo 'history' > "$HOME/.bash_history"
        chmod 600 "$HOME/.bash_history"
    else
        tail -n $HISTSIZE "${HOME}/.bash_history" > "${HOME}/.bash_history.$$"
        cat "${HOME}/.bash_history.$$" > "${HOME}/.bash_history"
        \rm -f "${HOME}/.bash_history.$$"
    fi

fi

# HOMEBREW
# See also: https://github.com/drduh/macOS-Security-and-Privacy-Guide/issues/138
if [ -d $HOME/homebrew ]; then
    HOMEBREW_PREFIX=$HOME/homebrew
    export HOMEBREW_PREFIX
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications --no-quarantine"
elif [ -d $HOME/usr/local ]; then
    HOMEBREW_PREFIX=$HOME/usr/local
    export HOMEBREW_PREFIX
    export HOMEBREW_NO_ANALYTICS=1
#    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--require-sha --appdir=/Applications"
else
    HOMEBREW_PREFIX=/nowhere
fi

#+++ Path list +++
CMD_PATH="$HOME/bin $HOME/sbin $HOMEBREW_PREFIX/bin"
CMD_PATH="$CMD_PATH $HOME/.cargo/bin"
CMD_PATH="$CMD_PATH /usr/local/bin /usr/local/sbin"
CMD_PATH="$CMD_PATH /usr/local/munki"
CMD_PATH="$CMD_PATH /usr/pkg/bin /usr/pkg/sbin"
CMD_PATH="$CMD_PATH /usr/pkg/libexec/netatalk"
CMD_PATH="$CMD_PATH /usr/ucb /usr/ccs/bin"
CMD_PATH="$CMD_PATH /usr/share/mailman/bin /usr/bin/cyrus/bin"
CMD_PATH="$CMD_PATH /usr/bin/cyrus/tools /usr/bin/cyrus/admin"
CMD_PATH="$CMD_PATH /usr/bin /usr/sbin /usr/libexec"
CMD_PATH="$CMD_PATH /bin /sbin"
CMD_PATH="$CMD_PATH /usr/X11R6/bin /usr/X11R6/sbin"
CMD_PATH="$CMD_PATH /sw/bin /sw/sbin"
CMD_PATH="$CMD_PATH /usr/games"
CMD_PATH="$CMD_PATH /snap/bin"
CMD_PATH="$CMD_PATH /var/qmail/bin"
CMD_PATH="$CMD_PATH /usr/local/pgsql/bin /usr/local/pgsql/sbin"
CMD_PATH="$CMD_PATH /usr/local/squid/bin /usr/local/squid/sbin"
CMD_PATH="$CMD_PATH /usr/local/atalk/bin /usr/local/netatalk/bin"
CMD_PATH="$CMD_PATH /usr/local/apache/bin /usr/local/apache/sbin"
CMD_PATH="$CMD_PATH /usr/local/samba/bin /usr/local/samba/sbin"
CMD_PATH="$CMD_PATH /usr/local/git/bin /usr/local/git/sbin"
CMD_PATH="$CMD_PATH /Developer/Tools"
CMD_PATH="$CMD_PATH /System/Library/ServerSetup"
CMD_PATH="$CMD_PATH /Applications/Server.app/Contents/ServerRoot/usr/bin"
CMD_PATH="$CMD_PATH /Applications/Server.app/Contents/ServerRoot/usr/sbin"
CMD_PATH="$CMD_PATH /Applications/Server.app/Contents/ServerRoot/usr/libexec"
CMD_PATH="$CMD_PATH /Applications/Server.app/Contents/ServerRoot/System/Library/ServerSetup"
CMD_PATH="$CMD_PATH /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources"
if [ -x /usr/bin/xcode-select ]; then
    if [ `sw_vers -productVersion | awk -F. '{print $2}'` -gt 8 ]; then
        XCODE_PATH=`/usr/bin/xcode-select -p` 2> /dev/null
        if [ ${XCODE_PATH:-X} != 'X' ]; then
            CMD_PATH="$CMD_PATH ${XCODE_PATH}/usr/bin"
        fi
    fi
fi

MAN_PATH="/usr/local/man"
MAN_PATH="$MAN_PATH $HOME/man"
MAN_PATH="$MAN_PATH /usr/local/lib/perl5/*/man"
MAN_PATH="$MAN_PATH /usr/local/atalk/man"
MAN_PATH="$MAN_PATH /usr/local/netatalk/man"
MAN_PATH="$MAN_PATH /usr/local/squid/man"
MAN_PATH="$MAN_PATH /usr/local/pgsql/man"
MAN_PATH="$MAN_PATH /usr/local/apache/man"
MAN_PATH="$MAN_PATH /usr/local/samba/man"
MAN_PATH="$MAN_PATH /usr/local/share/man"
MAN_PATH="$MAN_PATH /usr/share/man"
MAN_PATH="$MAN_PATH /usr/pkg/man"
MAN_PATH="$MAN_PATH /sw/share/man"
MAN_PATH="$MAN_PATH /usr/share/perl/man"
MAN_PATH="$MAN_PATH /usr/X11R6/man"
MAN_PATH="$MAN_PATH /var/qmail/man"
MAN_PATH="$MAN_PATH /Applications/Server.app/Contents/ServerRoot/usr/share/man"

#+++ Commands & Manual Search Path +++
PATH=`chck_path $CMD_PATH`
MANPATH=`chck_path $MAN_PATH`
export PATH
export MANPATH

#+++ PAGER +++
if [ "`type -P jless`" ]; then
  PAGER=jless
elif [ "`type -P less`" ]; then
  PAGER=less
  PERLDOC_PAGER='less -Ris'
  export PERLDOC_PAGER
else
  PAGER=more
fi
export PAGER

#+++ LANG Setting +++
# for PERL
PERL_BADLANG=0; export PERL_BADLANG

LC_TIME=C
LANG=ja_JP.UTF-8
LANGUAGE="$LANG"
LC_CTYPE="$LANG"
export LC_TIME LANG LANGUAGE LC_CTYPE

MYARCH=`uname -s`
case $MYARCH in
    NetBSD)
        CPUTYPE=`uname -m`
        if [ "jless" = $PAGER ]; then
            JLESSCHARSET=japanese; export JLESSCHARSET
        fi
        if [ "mac68k" = $CPUTYPE ]; then
            if ! [ "vt220" = $TERM ]; then
                TERM=vt220; export TERM
            fi
        fi
        export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig:/usr/local/lib/pkgconfig
        ;;
    Linux)
        LESSCHARSET=utf-8; export LESSCHARSET _CTYPE
        ;;
    Darwin)
#       if ! [ "vt100" = $TERM ]; then
#           TERM=vt100; export TERM
#       fi
        CLICOLOR=1
        LSCOLORS=DxGxcxdxCxegedabagacad
        LESSCHARSET=utf-8
        BASH_SILENCE_DEPRECATION_WARNING=1
        export LESSCHARSET CLICOLOR LSCOLORS BASH_SILENCE_DEPRECATION_WARNING
        ;;
    *)
        ;;
esac

# perlbrew
if [ -f "${HOME}/perl5/perlbrew/etc/bashrc" ]; then
  . "${HOME}/perl5/perlbrew/etc/bashrc"
fi

# ssh-agent for sierra
if [ ${TERM_PROGRAM:-X} = Apple_Terminal ]; then
    if [ `uname -r | awk -F . '{print $1}'` -ge 16 ]; then
        ssh-add -A 2> /dev/null
    fi
fi

# ssh-agent with screen
# http://www.gcd.org/blog/2006/09/100/
if [ ! -f "$HOME/.sshagent_free" ]; then
    HOSTNAME=`hostname -s`
    export SSHAGENT_SOCK="${HOME}/.ssh/.sshagent-${HOSTNAME}"
    export SSHAGENT_SOCK_NOTE="${HOME}/.ssh/.ssh_auth_socks-${HOSTNAME}"
    if [ -S "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK_ORIGINAL="$SSH_AUTH_SOCK"
        case "$SSH_AUTH_SOCK" in
            /tmp/*/agent.[0-9]* )
                ln -snf "$SSH_AUTH_SOCK" "$SSHAGENT_SOCK" && export SSH_AUTH_SOCK="$SSHAGENT_SOCK"
                echo "$SSH_AUTH_SOCK_ORIGINAL" >> "$SSHAGENT_SOCK_NOTE"
                ;;
            *)
                ;;
        esac
    elif [ -S "$SSHAGENT_SOCK" ]; then
        export SSH_AUTH_SOCK="$SSHAGENT_SOCK"
    fi
fi

#+++ MISC +++
if [ -f "$HOME/.bashrc_by_host" ]; then
  . "$HOME/.bashrc_by_host"
fi

if [ -f "$HOME/.bash_aliases" ]; then
  . "${HOME}/.bash_aliases"
fi

if [ -f "$HOME/.git-completion.bash" ] && [ "`type -P git`" ]; then
    . "$HOME/.git-completion.bash"
fi

if [ -f "$HOMEBREW_PREFIX/completions/bash/brew" ]; then
    . "$HOMEBREW_PREFIX/completions/bash/brew"
elif [ -f /usr/local/Homebrew/completions/bash/brew ]; then
    . /usr/local/Homebrew/completions/bash/brew
fi
if [ -f "${HOMEBREW_PREFIX}/etc/bash_completion" ]; then
    . "${HOMEBREW_PREFIX}/etc/bash_completion"
elif [ -f "/usr/local/etc/bash_completion" ]; then
    . "/usr/local/etc/bash_completion"
fi

unset TMOUT CNAME ME CMD_PATH MAN_PATH MYARCH
