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
        if [ -f /etc/issue ]; then DISTRIBUTION=`head -1 /etc/issue` ; fi
        echo "This is ${CURRENT_SYSTEM}/${CURRENT_MPU} ${DISTRIBUTION:=unknown}: ${CURRENT_RELEASE:=unknown}."
    ;;
    *)
        echo "This is a ${CURRENT_MPU}-unknown-${CURRENT_SYSTEM} $CURRENT_RELEASE system."
    ;;
esac

if [ "`type -p fortune`" ]; then fortune -s ; fi
echo ""
