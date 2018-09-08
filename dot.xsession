# Window Maker default X session startup script 
#

PATH="$PATH:/usr/X11R6/bin"

# If you login from xdm, uncomment this to make error messages appear
# in the console window.
#
tail -f /home/hoi/.xsession-errors > /dev/console &
if [ `type -P ssh-agent` ]; then
	eval `ssh-agent`
	ssh-add  $HOME/.ssh/id_dsa
fi

kinput2 -canna &
oneko -bsd &

exec wmaker
#WM_PID=$!
#echo $WM_PID > /tmp/WM_PID
#wait $WM_PID
#if [ $SSH_AGENT_PID ]; then
#	eval `ssh-agent -k`
#fi
