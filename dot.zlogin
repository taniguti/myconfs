if [ -f "${HOME}/.systeminfo" ]; then . "${HOME}/.systeminfo" ; fi

ssh-add -A 2> /dev/null

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
                echo "$SSH_AUTH_SOCK_ORIGINAL" >>| "$SSHAGENT_SOCK_NOTE"
                ;;
            *)
                ;;
        esac
    elif [ -S "$SSHAGENT_SOCK" ]; then
        export SSH_AUTH_SOCK="$SSHAGENT_SOCK"
    fi
fi
