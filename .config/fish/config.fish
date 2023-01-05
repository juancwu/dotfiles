set fish_greeting ""

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
status is-interactive && eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Go
set -g GOPATH $HOME/go 

# Add gobin to path
fish_add_path $GOPATH/bin

# load configuration files based on OS
switch (uname)
  case Darwin
    set DARWIN_CONFIG (dirname (status --current-file))/config-darwin.fish
    if test -f $DARWIN_CONFIG
      source $DARWIN_CONFIG
    end
  case Linux
    set LINUX_CONFIG (dirname (status --current-file))/config-linux.fish
    if test -f $LINUX_CONFIG
      source $LINUX_CONFIG
    end
end

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

alias cc clear

if type -q git
    alias g git
    alias gb "git branch"
    alias gm "git commit"
    alias gc "git checkout"
    alias gs "git status -sb"
    alias gp "git push"
    alias gP "git pull --rebase"
    alias ga "git add"
end

if type -q tmux
    alias tma "tmux attach"
    alias tmls "tmux list-session"
    alias tmks "tmux kill-session"
end

# allow local config overwrite
set LOCAL_CONFIG (dirname (status --current-file))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end
