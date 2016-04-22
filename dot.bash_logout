#
# LOGOUT COMMAND FILE for BASH
# 

clear

case $TERM in
	Eterm | kterm | xterm )
	;;
	*)
		if  [ $SSH_AGENT_PID ]; then
			ssh-agent -s -k
		fi
	;;
esac
