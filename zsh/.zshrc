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
    if command -v fd > /dev/null 2>&1; then
        # do nothing, command exists
    else
        echo -e "$ERROR Error: 'fd' is not installed." >&2
        return 1
    fi

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
            fd -t d --color never "${exclude_args[@]}" . "$HOME/ghq" 2>/dev/null
        } | fzf --filter="$1" --select-1 --exit-0 | head -1)
    else
        selected_dir=$({
            fd -t d --color never "${exclude_args[@]}" . "$HOME/ghq" 2>/dev/null
        } | fzf)
    fi

	if [ -n "$selected_dir" ]; then
		cd "$selected_dir"
	fi
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

# Load colors if possible
autoload -U colors && colors

# Set prompt
setopt PROMPT_SUBST
PS1="%n@%m:%~\$(parse-git-branch) $ "

unset color_prompt

export EDITOR=nvim
