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
# setopt EXTENDED_GLOB
gc() {
    local url=$1
    local ghq_dir="$HOME/ghq"

    # extract project name
    if [[ $url =~ git@github\.com:([^/]+)/([^/]+)\.git ]]; then
        local project_name="${match[1]}"
        local repository_name="${match[2]}"
    elif [[ $url =~ https://github\.com/([^/]+)/([^/]+)\.git ]]; then
        local project_name="${match[1]}"
        local repository_name="${match[2]}"
    else
        echo "Invalid URL format"
        return 1
    fi

    # check if directory for project exists or not
    local project_dir="${ghq_dir}/${project_name}/${repository_name}"
    echo $project_dir
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
