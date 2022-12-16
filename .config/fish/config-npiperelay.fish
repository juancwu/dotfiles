# Configure ssh forwarding
set -x SSH_AUTH_SOCK $HOME/.ssh/agent.sock

# use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
set ALREADY_RUNNING (ps -aux | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $status)

if [ $ALREADY_RUNNING -ne 0 ]
    if [ -S $SSH_AUTH_SOCK ]
        # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
        # echo "removing previous socket..."
        rm $SSH_AUTH_SOCK
    end

    # echo "Starting SSH-Agent relay..."
    # setsid to force new session to keep running
    # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
    begin
        setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork >/dev/null 2>&1 &
    end
end
