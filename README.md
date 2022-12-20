# Overview

One place to keep all my general configurations to setup my development environment on the terminal.

The configurations in this repository are highly inspired by and referenced from: 
- [craftzdog](https://github.com/craftzdog/dotfiles-public)
- [ThePrimeagen](https://github.com/ThePrimeagen/init.lua)

# Terminal Colourscheme

## Basic Colours

- Foreground: #839496
- Background: #001f27
- Bold: #93a1a1
- Links: #005bbb
- Selection: #073642
- Selected text: #93a1a1

## ANSI Colours

### Normal

- Black: #073642
- Red: #dc322f
- Green: #859900
- Yellow: #b58900
- Blue: #268bd2
- Magenta: #d33682
- Cyan: #2aa198
- White: #eee8d5

### Bright

- Black: #002b36
- Red: #cb4b16
- Green: #586e75
- Yellow: #657b83
- Blue: #839496
- Magenta: #6c71c4
- Cyan: #93a1a1
- White: #fdf6e3

## Cursor Colours

- Cursor: #839496
- Cursor text: #073642

# Instructions Based on OS

These are set of instructions to setup the terminal (fish and neovim).

- [Linux](docs/linux.md)
- [Mac](docs/macos.md)

# Other Setups

## 1Password Configuration SSH-Agent

Use 1Password SSH-Agent for SSH authentication and commit signing.

### Windows & WSL2

We need to create a bridge with named pipes between Windows and WSL2 so that WSL2 can use 1Password SSH-Agent.

#### Steps

1. Enable Windows Hello in Settings
2. Install [npiperelay.exe](https://1password.community/home/leaving?allowTrusted=1&target=https%3A%2F%2Fgithub.com%2Fjstarks%2Fnpiperelay)
   - You can install it using go
   - Or use Scoop:
   ```
   scoop bucket add extras
   scoop install npiperelay
   ```
   **Note**: Installation is from Windows side using PowerShell.
3. Set up script that configures the SSH forwarding.

```
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
```

5. Restart terminal.
6. Test with `ssh-add -l`. This should output the 1Password SSH keys.

### MacOS

MacOS setup is pretty straight forward.

#### Steps

1. Open the settings page of 1Password.
2. Go to the `Developer`.
3. Turn on `Use the SSH agent` option.
4. Configure singed commits

### Configure Signed Commits

This will make each commit show as `verified` on GitHub.

1. Open the SSH key that is going to be used in the 1Password app.
2. Click the three dots and configure signing.
3. On Mac, you can let it automatically configure everything.
4. On Linux, you have to manually copy the content and modify the `.gitconfig` file.