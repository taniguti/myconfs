#
# LOGOUT COMMAND FILE for BASH
#

if [ -f "$SSHAGENT_SOCK_NOTE" -a -S "$SSH_AUTH_SOCK_ORIGINAL" ]; then
    grep -v "$SSH_AUTH_SOCK_ORIGINAL" "$SSHAGENT_SOCK_NOTE" | awk 'NF' > "${SSHAGENT_SOCK_NOTE}.$$"
    /bin/mv -f "${SSHAGENT_SOCK_NOTE}.$$" "$SSHAGENT_SOCK_NOTE"
    SSH_AUTH_SOCK_TO_DELETE="$( /bin/ls -l "$SSHAGENT_SOCK" | awk '{print $NF}' )"

    if [ "$SSH_AUTH_SOCK_ORIGINAL" = "$SSH_AUTH_SOCK_TO_DELETE" ]; then
        for S in $( cat "$SSHAGENT_SOCK_NOTE" ) X
        do
            if [ -S $S ]; then
                ln -snf "$S" "$SSHAGENT_SOCK"
                break
            elif [ $S = X ]; then
                /bin/rm -f "$SSHAGENT_SOCK" "$SSHAGENT_SOCK_NOTE"
            else
                grep -v "$S" "$SSHAGENT_SOCK_NOTE" | awk 'NF' > "${SSHAGENT_SOCK_NOTE}.$$"
                /bin/mv -f "${SSHAGENT_SOCK_NOTE}.$$" "$SSHAGENT_SOCK_NOTE"
            fi
        done
    fi
fi

clear
