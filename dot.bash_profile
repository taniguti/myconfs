#
# Dot.Bash_Profile   written by taniguti
# 

CURRENT_SYSTEM=`uname -s`
CURRENT_RELEASE=`uname -r`
CURRENT_MPU=`uname -m`

if [ -x /sw/bin/init.sh ]; then . /sw/bin/init.sh ; fi
if [ -f ~/.bashrc ]; then . ~/.bashrc ; fi

case $CURRENT_SYSTEM in
    NetBSD)
        # use /etc/motd.
    ;;
    Darwin)
        MACTYPE=`system_profiler SPHardwareDataType | awk '$2 == "Identifier:" {print $3}'`
        echo "This is ${MACTYPE:=unknown} running with ${CURRENT_SYSTEM}/${CURRENT_MPU} $CURRENT_RELEASE."
	  ;;
    Linux)
        if [ -f /etc/system-release ]; then DISTRIBUTION=`cat /etc/system-release` ; fi
        echo "This is ${CURRENT_SYSTEM}/${CURRENT_MPU} ${DISTRIBUTION:=unknown}: ${CURRENT_RELEASE}."
    ;;
    *)
        echo "This is a ${CURRENT_MPU}-unknown-${CURRENT_SYSTEM} $CURRENT_RELEASE system."
    ;;
esac

if [ -x /usr/games/fortune ]; then fortune -s ; fi

# SSH Setting
if [ "${SSH_CLIENT:-X}" = "X" -a -f "$HOME/.bash_sshagent" ]; then
    . "$HOME/.bash_sshagent"
fi

echo ""
