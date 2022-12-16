set fish_greeting ""

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
status is-interactive && eval /home/jc/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Go
set -g GOPATH $HOME/go 

# Add gobin to path
fish_add_path $GOPATH/bin

# load configuration files based on OS
switch (uname)
  case Darwin
    source (dirname (status --current-file))/config-darwin.fish
  case Linux
    source (dirname (status --current-file))/config-linux.fish
end

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

# allow local config overwrite
set LOCAL_CONFIG (dirname (status --current-file))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end
