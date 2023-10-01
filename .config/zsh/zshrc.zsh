ZSH_CONFIG="$(dirname ${(%):-%x})"

# Functions!
source "$ZSH_CONFIG/dotfiles/.config/zsh/functions.zsh"

# Aliases
source "$ZSH_CONFIG/dotfiles/.config/zsh/aliases.zsh"

export PATH=/Users/jc/Library/Python/3.8/bin:$PATH
export BREW_PYTHON=/opt/homebrew/bin/python3

# NVM !!
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/jc/.bun/_bun" ] && source "/Users/jc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# PRETTIERD
export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc.json"
