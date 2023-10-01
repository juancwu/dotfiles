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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=normal -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Set prompt
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
fi

command -v pnpm > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING pnpm is not installed"
fi

command -v gh > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING gh cli is not installed"
fi

command -v nvim > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$ERROR neovim is not installed"
fi

command -v yarn > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING yarn is not installed"
fi

command -v bun > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING bun is not installed"
fi

command -v notify-send > /dev/null 2>%1
if [ $? -ne 0 ]; then
    echo -e "$WARNING notify-send is not installed. Will affect the alias: \033[34;49;1malert\033[0m"
fi
