#
# LOGOUT COMMAND FILE for ZSH
#

zlogoutlog="/tmp/zlogout.$(whoami).$$.log"

if [ -f "$SSHAGENT_SOCK_NOTE" ] && [ -S "$SSH_AUTH_SOCK_ORIGINAL" ]; then
    echo "$(date +"%F %T"): SSHAGENT_SOCK_NOTE: $SSHAGENT_SOCK_NOTE" >>"$zlogoutlog"
    echo "$(date +"%F %T"): SSH_AUTH_SOCK_ORIGINAL: $SSH_AUTH_SOCK_ORIGINAL" >>"$zlogoutlog"

    grep -v "$SSH_AUTH_SOCK_ORIGINAL" "$SSHAGENT_SOCK_NOTE" | awk 'NF' >"${SSHAGENT_SOCK_NOTE}.$$"
    /bin/mv -f "${SSHAGENT_SOCK_NOTE}.$$" "$SSHAGENT_SOCK_NOTE"
    SSH_AUTH_SOCK_TO_DELETE="$(/bin/ls -l "$SSHAGENT_SOCK" | awk '{print $NF}')"
    echo "$(date +"%F %T"): SSH_AUTH_SOCK_TO_DELETE: $SSH_AUTH_SOCK_TO_DELETE" >>"$zlogoutlog"

    if [ "$SSH_AUTH_SOCK_ORIGINAL" = "$SSH_AUTH_SOCK_TO_DELETE" ]; then
        echo "$(date +"%F %T"): SSH_AUTH_SOCK_ORIGINAL is SSH_AUTH_SOCK_TO_DELETE" >>"$zlogoutlog"
        for S in $(cat "$SSHAGENT_SOCK_NOTE") X; do
            echo "$(date +"%F %T"): S is $S" >>"$zlogoutlog"
            if [ -S "$S" ]; then
                ln -snf "$S" "$SSHAGENT_SOCK"
                echo "$(date +"%F %T"): renew symlick $SSHAGENT_SOCK then break" >>"$zlogoutlog"
                break
            elif [ "$S" = X ]; then
                echo "$(date +"%F %T"): No more SSH agent. All socket file will be removed." >>"$zlogoutlog"
                /bin/rm -f "$SSHAGENT_SOCK" "$SSHAGENT_SOCK_NOTE"
            else
                echo "$(date +"%F %T"): Remove $S from $SSHAGENT_SOCK_NOTE" >>"$zlogoutlog"
                grep -v "$S" "$SSHAGENT_SOCK_NOTE" | awk 'NF' >"${SSHAGENT_SOCK_NOTE}.$$"
                /bin/mv -f "${SSHAGENT_SOCK_NOTE}.$$" "$SSHAGENT_SOCK_NOTE"
            fi
        done
    fi
fi
