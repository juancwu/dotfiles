# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
status is-interactive && eval /home/jc/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Go
set -g GOPATH $HOME/go
set -g GOBIN $GOPATH/bin

# Add gobin to path
fish_add_path $GOBIN

#x-server
set -g DISPLAY $(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end
