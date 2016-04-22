#
# Dot.Bash_Profile   written by taniguti
# 

CURRENT_SYSTEM=`uname -s`
CURRENT_RELEASE=`uname -r`
CURRENT_MPU=`uname -m`

if [ -x /sw/bin/init.sh ]; then
	. /sw/bin/init.sh
fi
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

case $CURRENT_SYSTEM in
NetBSD)
	;;
*)
	if [ $MACTYPE ]; then
        	echo "This is a $MACHTYPE system($MACTYPE)."
	else
        	echo "This is a ${CURRENT_MPU}-unknown-${CURRENT_SYSTEM} $CURRENT_RELEASE system."
	fi
	echo ""
	;;
esac

if [ -x /usr/games/fortune ]; then
	fortune -s
fi

# SSH Setting
if [ "$SSH_CLIENT" = "" -a -f "$HOME/.bash_sshagent" ]; then
	source  $HOME/.bash_sshagent
fi
