#
# COMMAND ALIAS FILE for BASH
#

HOSTTYPE=$( uname -s )
HOSTNAME=$( hostname -s )

alias al='alias'

case ${HOSTTYPE} in
    Darwin)
        alias cp='cp -aivc'
        alias ls='ls -ahFCv'
        alias df='df -h'
        alias du='du -h'
        alias kinit='kinit --renewable'
        alias ssh-add='ssh-add -K'
        alias top='top -u'
        if [ "$( /usr/bin/fdesetup status | head -1 | awk '$NF == "On." {print NR}' )"X = 1X ]; then
            alias reboot="sync;sync;sync;sudo /usr/bin/fdesetup authrestart"
        fi
        if [ -f ${HOME}/.ssh/mypass ]; then
            alias mypass='cat ${HOME}/.ssh/mypass | pbcopy'
        fi
        ;;
    NetBSD)
        alias ls='ls -aFCh'
        alias df='df -k'
        alias du='du -k'
        alias halt='halt -p'
        alias cp='cp -aiv'
        ;;
    Linux)
        alias ls='ls --color=tty --show-control-char -aFCh'
        ;;
    *)
        if [ "$( type -P ja-ls )" ]; then
            alias ls='ja-ls -aFEC'
        else
            alias ls='ls -aFCh'
        fi
        alias df='df -k'
        alias du='du -k'
        alias cp='cp -aiv'
        ;;
esac

alias ll='ls -ohlh'
alias lld='ll -dh'
alias llt='ll -t'
alias llo='ll -o'
alias lle='ll -e'
alias mv='mv -vi'
alias rm='rm -vi'
alias rmf='rm -vrf'
alias diff='diff -Npru'
alias back='cd -'
alias clr='clear'
alias uchg='chflags uchg'
alias schg='chflags schg'
alias noschg='chflags noschg'
alias nouchg='chflags nouchg'
alias me='whoami'
alias z='suspend'
alias h='history'
alias bye='exit'
alias where='type -a'
alias j='jobs'
alias shibuya='curl wttr.in/tokyo'
alias perlck='perl -Mstrict -Mwarnings -wc'
alias tcpdump='sudo tcpdump -s0 -X -vv'
alias getgip='curl -L --retry 3 --retry-max-time 10 http://ifconfig.moe/ip'
alias less='less -R'
alias ssh='ssh -C'
alias scp='scp -C'

if [ "jless" = ${PAGER:=x} ];then
    alias less='jless'
elif [ "more" = $PAGER ];then
    alias less='more'
fi

if [ "$( type -P jman )" ]; then
    alias man='jman'
fi

if [ "$( type -P gzcat )" ]; then
    alias zcat='gzcat'
fi

if [ "$( type -P gmake )" ]; then
	alias	 make='gmake'
fi

if [ "$( type -P gtar )" ]; then
	alias	 tar='gtar'
fi

if [ "$( type -P jvim )" ]; then
	alias	 vi=jvim
fi

if [ "$( type -P gpatch )" ]; then
	alias	 patch=gpatch
fi

if [ "$( type -P strace )" ]; then
    alias strace='strace -s 1024 -t'
fi

if [ "$( type -P vim )" ]; then
    alias vi=vim
fi

if [ "$( type -P sudo )" ]; then
    alias sudo='sudo -H'
fi

if [ -f ${HOME}/.bash_aliases_by_host ]; then
    . ${HOME}/.bash_aliases_by_host
fi

unset ME HOSTTYPE HOSTNAME
