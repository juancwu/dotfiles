# list directory and cd into it
sd() {
	local path=${1:-.}
	local result=$(ls -d ${path}/*/ 2> /dev/null | fzf)
	if [[ -n "${result}" ]]; then
		cd "${result}"
	else
		echo "No directories found or no selection made."
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
		echo "No files found or no selecteion made."
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
		echo "No selection made."
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
        echo "Invalid URL format"
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

# Set prompt
color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]\$(parse_git_branch)\[\033[00m\] \$ "
else
    PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(parse_git_branch)\$ "
fi
unset color_prompt

# install curl to complete auto installs
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)

# auto install nvm
command -v nvm > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NVM is not installed. Installing now..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
  echo "NVM is now installed. Installing node..."
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install lts && nvm use lts
  echo "Node is now installed."
fi

# auto install pnpm
command -v pnpm > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "PNPM is not installed. Installing now..."
  export SHELL=/bin/bash
  curl -fsSL https://get.pnpm.io/install.sh | sh -
	# pnpm
	export PNPM_HOME="/root/.local/share/pnpm"
	case ":$PATH:" in
	  *":$PNPM_HOME:"*) ;;
	  *) export PATH="$PNPM_HOME:$PATH" ;;
	esac
	# pnpm end
  echo "PNPM is now installed."
fi

# auto install gh cli
command -v gh > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "GitHub CLI is not installed. Installing now..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
  
  echo "GitHub CLI is now installed."
fi

# auto install neovim
command -v nvim > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "NeoVim is not installed. Installing now..."
  mkdir -p ~/opt
  curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -o ~/opt/nvim-linux64.tar.gz
  tar xzf ~/opt/nvim-linux64.tar.gz -C ~/opt

  # create symlink
  ln -s ~/opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
  # create symlink as vim if vim is not installed
  type -p vim >/dev/null || ln -s ~/opt/nvim-linux64/bin/nvim /usr/local/bin/vim

  # remove tar file
  rm ~/opt/nvim-linux64.tar.gz

  echo "NeoVim is now installed."
fi

export PATH=$PATH:/usr/local/go/bin:/home/jc/go/bin
