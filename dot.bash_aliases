#
# COMMAND ALIAS FILE for BASH
#

HOSTTYPE=`uname -s`
HOSTNAME=`hostname -s`

alias al='alias'

case ${HOSTTYPE} in
	Darwin)
		alias	ls='ls -ahFCv'
		alias	df='df -h'
		alias	du='du -h'
		alias	refreshmail='/usr/bin/sqlite3 ~/Library/Mail/Envelope\ Index vacuum'
    alias ssh-add='ssh-add -K'
    alias top='top -u'
		;;
	NetBSD)
		alias	df='df -k'
		alias	du='du -k'
		;;
	Linux)
		alias ls='ls --color=tty --show-control-char -aFCh'
		;;
	*)
		if [ `type -p ja-ls` ]; then
			alias	 ls='ja-ls -aFEC'
		else
			alias ls='ls -aFC'
		fi
		alias	 df='df -h'
		alias	 du='du -h'
		;;
esac

alias	 ll='ls -ohlh'
alias	 lld='ll -dh'
alias	 llt='ll -t'
alias	 llo='ll -o'
alias	 lle='ll -e'
alias	 mv='mv -vi'
alias	rm='rm -vi'
alias	rmf='rm -vrf'
alias	 cp='cp -aiv'
alias	 diff='diff -Npru'
alias	 back='cd "$OLDPWD";echo $PWD'
alias	 clr='clear'
alias	 uchg='chflags uchg'
alias	 schg='chflags schg'
alias	 noschg='chflags noschg'
alias	 nouchg='chflags nouchg'
alias	 z='suspend'
alias	 h='history'
alias	 bye='exit'
alias	 where='type -a'
alias	 j='jobs'
alias	 halt='sync;sync;sync;sudo shutdown -h now'
alias	 reboot='sync;sync;sync;sudo reboot'
alias  shibuya='curl wttr.in/tokyo'
alias  getgip='curl http://ifconfig.me'
alias  kinit='kinit --renewable'

if [ "jless" = $PAGER ];then
	alias	 less='jless'
elif [ "more" = $PAGER ];then
	alias	 less='more'
fi

if [ `type -p jman` ]; then
	alias	 man='jman'
fi

if [ `type -p gzcat` ]; then
	alias	 zcat='gzcat'
fi

if [ `type -p svstat` -a  `type -p sudo` ]; then
	alias	 svstat='sudo svstat'
fi

if [ `type -p svc` -a  `type -p sudo` ]; then
	alias	 svc='sudo svc'
fi

if [ `type -p gmake` ]; then
	alias	 make='gmake'
fi

if [ `type -p gtar` ]; then
	alias	 tar='gtar'
fi

if [ `type -p jvim` ]; then
	alias	 vi=jvim
fi

if [ `type -p gpatch` ]; then
	alias	 patch=gpatch
fi

if [ `type -p strace` ]; then
    alias strace='strace -s 1024 -t'
fi

if [ -f ${HOME}/.bash_aliases_by_host ]; then
    . ${HOME}/.bash_aliases_by_host
fi

unset ME HOSTTYPE HOSTNAME
