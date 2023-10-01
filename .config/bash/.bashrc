# --------------  Aliases
alias gs="git status"

# ll alias breakdown
# -a includes hidden files
# -l displays the listing in long format, showing file attributes such as permissions
# -F appends a character to each entry in the listing to indicate the file type (e.g '/' for directories and '*' for executables)
alias ll="ls -alF"

# la alias breakdown
# -A list all entries without ./ and ../
alias la="ls -A"

# l alias breakdown
# -C list entries by columns
# -F appends a character to each entry in the listing to indicate the file type (e.g '/' for directories and '*' for executables)
alias l="ls -CF"

# Nice line headers for logs
ERROR=$'\033[39;41mERROR:\033[0m'
SUCCESS=$'\033[39;42mSUCCESS:\033[0m'
WARNING=$'\033[39;43mWARNING:\033[0m'
INFO=$'\033[39;44mINFO:\033[0m'


# --------------  Functions
# list directory and cd into it
sd() {
	local path=${1:-.}
	local result=$(ls -d ${path}/*/ 2> /dev/null | fzf)
	if [[ -n "${result}" ]]; then
		cd "${result}"
	else
		echo -e "$ERROR No directories found or no selection made."
	fi
}

# list files and opens it in neovim
sf() {
	local path=${2:-.}
  if [[ $1 == "-h" ]]; then
    local result=$(find ${path} -type f -name '.*' 2> /dev/null | fzf)
  else
    local result=$(find ${path} -type f 2> /dev/null | fzf)
  fi
	if [[ -n "${result}" ]]; then
		nvim "${result}"
	else
		echo -e "$ERROR No files found or no selecteion made."
	fi
}

# fuzzy cd into specific folders 
fcd() {
	local selected_dir=$({
		echo "$HOME/.config"
		find "$HOME/ghq" -mindepth 2 -maxdepth 2 -type d
		ls -d -1 "$HOME/"/*/ | grep -v \.git
		ls -d -1 */ | perl -pe "s#^#$PWD/#" | grep -v \.git
	} | fzf)

	if [ -n "$selected_dir" ]; then
		cd "$selected_dir"
		if [[ -f .nvmrc ]]; then
			NVMRC_VERSION=$(cat .nvmrc)
			CURRENT_VERSION=$(nvm current)
			if [ "$NVMRC_VERSIOn" != "$CURRENT_VERSION" ]; then
				nvm use
			fi
		fi
	else
		echo -e "$ERROR No selection made."
	fi
}

# clone repository
gc() {
    local url=$1
    local ghq_dir="$HOME/ghq"

    # extract project name
    if [[ $url =~ git@github\.com:([^/]+)/([^/]+)\.git ]]; then
        local project_name="${BASH_REMATCH[1]}"
        local repository_name="${BASH_REMATCH[2]}"
    elif [[ $url =~ https://github\.com/([^/]+)/([^/]+)\.git ]]; then
        local project_name="${BASH_REMATCH[1]}"
        local repository_name="${BASH_REMATCH[2]}"
    else
        echo -e "$ERROR Invalid URL format"
        return 1
    fi

    # check if directory for project exists or not
    local project_dir="${ghq_dir}/${project_name}/${repository_name}"
    if [[ ! -d $project_dir ]]; then
        mkdir -p $project_dir
    fi

    git clone $url $project_dir
}

# get branch if available
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# delete local branches that don't exists in remote repository
git-prune() {
    git fetch --prune
    git branch -vv | grep '\[origin/.*: gone\]' | awk '{print $1}' | xargs git branch -d
}

# Set prompt
color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]\$(parse_git_branch)\[\033[00m\] \$ "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(parse_git_branch)\$ "
fi
unset color_prompt

type -p curl >/dev/null || echo -e "$WARNING curl is not installed"

command -v nvm > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING nvm is not installed"
 #  echo "NVM is not installed. Installing now..."
 #  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
 #  echo "NVM is now installed. Installing node..."
	# export NVM_DIR="$HOME/.nvm"
	# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
 #  nvm install lts && nvm use lts
 #  echo "Node is now installed."
fi

command -v pnpm > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING pnpm is not installed"
 #  echo "PNPM is not installed. Installing now..."
 #  export SHELL=/bin/bash
 #  curl -fsSL https://get.pnpm.io/install.sh | sh -
	# # pnpm
	# export PNPM_HOME="/root/.local/share/pnpm"
	# case ":$PATH:" in
	#   *":$PNPM_HOME:"*) ;;
	#   *) export PATH="$PNPM_HOME:$PATH" ;;
	# esac
	# # pnpm end
 #  echo "PNPM is now installed."
fi

command -v gh > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING gh cli is not installed"
  # echo "GitHub CLI is not installed. Installing now..."
  # curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  # && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  # && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  # && sudo apt update \
  # && sudo apt install gh -y
  # 
  # echo "GitHub CLI is now installed."
fi

command -v nvim > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$ERROR neovim is not installed"
  # echo "NeoVim is not installed. Installing now..."
  # mkdir -p ~/opt
  # curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -o ~/opt/nvim-linux64.tar.gz
  # tar xzf ~/opt/nvim-linux64.tar.gz -C ~/opt
  #
  # # create symlink
  # ln -s ~/opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
  # # create symlink as vim if vim is not installed
  # type -p vim >/dev/null || ln -s ~/opt/nvim-linux64/bin/nvim /usr/local/bin/vim
  #
  # # remove tar file
  # rm ~/opt/nvim-linux64.tar.gz
  #
  # echo "NeoVim is now installed."
fi

command -v yarn > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING yarn is not installed"
fi

command -v bun > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING bun is not installed"
fi

export PATH=$PATH:/usr/local/go/bin:/home/jc/go/bin

export PRETTIERD_DEFAULT_CONFIG="$HOME/.prettierrc.json"
