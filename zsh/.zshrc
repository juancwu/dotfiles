alias ls='lsd'
alias grep='grep --color=auto'
alias gs="git status"
alias gb="git branch"
alias ll="lsd -alF"
alias la="lsd -A"
alias l="lsd -CF"
alias lg="lazygit"
alias vim="nvim"

# Nice line headers for logs
ERROR=$'\033[39;41mERROR:\033[0m'
SUCCESS=$'\033[39;42mSUCCESS:\033[0m'
WARNING=$'\033[39;43mWARNING:\033[0m'
INFO=$'\033[39;44mINFO:\033[0m'

# ------------ Functions!
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
    # Common directories to exclude
    local exclude_args=(
        --exclude ".git"
        --exclude "node_modules"
        --exclude "vendor"
        --exclude ".cache"
        --exclude "dist"
        --exclude "build"
        --exclude "target"
        --exclude ".next"
        --exclude ".nuxt"
        --exclude "__pycache__"
        --exclude ".pytest_cache"
        --exclude ".venv"
        --exclude "venv"
        --exclude "env"
        --exclude ".env"
        --exclude "coverage"
        --exclude ".nyc_output"
        --exclude ".sass-cache"
        --exclude "bower_components"
        --exclude ".idea"
        --exclude ".vscode"
        --exclude ".vs"
        --exclude "*.egg-info"
        --exclude ".tox"
        --exclude ".mypy_cache"
        --exclude ".ruff_cache"
        --exclude ".turbo"
        --exclude "out"
        --exclude "tmp"
        --exclude ".svn"
        --exclude ".hg"
        --exclude ".bzr"
        --exclude "_remote"
    )

    local selected_dir=""

    if [ $# -eq 1 ]; then
        selected_dir=$({
            # Search in ghq projects (your git repositories)
            fd -t d --full-path --color never "${exclude_args[@]}" . "$HOME/ghq" 2>/dev/null
        } | fzf --filter="$1" --select-1 --exit-0 | head -1)
    else
        selected_dir=$({
            # Search in ghq projects (your git repositories)
            fd -t d --full-path "${exclude_args[@]}" . "$HOME/ghq" 2>/dev/null
        } | fzf)
    fi

	if [ -n "$selected_dir" ]; then
		cd "$selected_dir"
		if [[ -f .nvmrc ]]; then
			NVMRC_VERSION=$(cat .nvmrc)
			CURRENT_VERSION=$(nvm current)
			if [ "$NVMRC_VERSION" != "$CURRENT_VERSION" ]; then
				nvm use
			fi
		fi
	else
		echo "No selection made."
	fi
}

# clone repository
# setopt EXTENDED_GLOB
cl() {
    if [[ $# -eq 0 ]]; then
        # help text
        echo "Usage: cl REPOSITORY_NAME"
        echo "Usage: cl REPOSITORY_URL"
        echo "Usage: cl (hub|lab) REPOSITORY_NAME"
        echo "Usage: cl (hub|lab) NAMESPACE REPOSITORY_NAME"
        return 0
    fi

    local url=$1
    local ghq_dir="$HOME/ghq"
    local namespace=""
    local repository_name=""

    # extract project name
    if [[ $url =~ git@git(lab|hub)\.com:([^/]+)/([^/]+)\.git ]]; then
        namespace="${match[2]}"
        repository_name="${match[3]}"
    elif [[ $url =~ https://git(lab|hub)\.com/([^/]+)/([^/]+)\.git ]]; then
        namespace="${match[2]}"
        repository_name="${match[3]}"
    elif [[ $# -ne 0 ]]; then
        repository_name=$1
        namespace="juancwu"
        local domain="hub"

        if [[ $# -eq 2 ]]; then
            domain=$1
            repository_name=$2
        fi

        if [[ $# -eq 3 ]]; then
            domain=$1
            namespace=$2
            repository_name=$3
        fi

        url="git@git$domain.com:$namespace/$repository_name.git"
    else
        echo "Invalid URL format"
        return 1
    fi

    # check if directory for project exists or not
    local project_dir="${ghq_dir}/${namespace}/${repository_name}"
    echo $project_dir
    if [[ ! -d $project_dir ]]; then
        mkdir -p $project_dir
    fi

    git clone $url $project_dir
}

# fuzzy find branches and switch to selected branch
gc() {
    if [ $# -eq 1 ]; then
        local selected_branch=$(git branch | fzf --filter="$1" --select-1 --exit-0 | head -1 | sed 's/^[ \*]*//')
        git checkout "$selected_branch"
        return
    fi

    local selected_branch=$(git branch | fzf | sed 's/^[ \*]*//')

    if [ -n "$selected_branch" ]; then
        git checkout "$selected_branch"
    else
        echo "No branch selected"
    fi
}

# fuzzy find remote branches and switch to selected branch
gcr() {
    git fetch

    if [ $# -eq 1 ]; then
        local selected_branch=$(git branch -r | fzf --filter="$1" --select-1 --exit-0 | head -1 | sed -E 's/^([ \*]*origin\/[\ *]*)*//')
        git checkout "$selected_branch"
        return
    fi

    local selected_branch=$(git branch -r | fzf | sed -E 's/^([ \*]*origin\/[\ *]*)*//')

    if [ -n "$selected_branch" ]; then
        git checkout "$selected_branch"
    else
        echo "No branch selected"
    fi
}

# get branch if available
parse-git-branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# delete local branches that don't exists in remote repository
git-prune() {
    git fetch --prune
    git branch -vv | grep '\[origin/.*: gone\]' | awk '{print $1}' | xargs git branch -d
}

# helper function to fuzzy search files in the current working directory
ed() {
    local f=""

    if [ $# -eq 1 ]; then
        f=$(find . | grep -Ev "node_modules|\.git/" | fzf --filter="$1" --select-1 --exit-0 | head -1)
    else
        f=$(find . | grep -Ev "node_modules|\.git/" | fzf)
    fi

    if [ -n "$f" ]; then
        nvim "$f"
    fi
}

# Load colors if possible
autoload -U colors && colors

# Set prompt
setopt PROMPT_SUBST
PS1="%n@%m:%~\$(parse-git-branch) $ "

unset color_prompt

export EDITOR=nvim
