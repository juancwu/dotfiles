# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
status is-interactive && eval /Users/jc/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

eval "$(/opt/homebrew/bin/brew shellenv)"

# Go
set -g GOPATH $HOME/go

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end
