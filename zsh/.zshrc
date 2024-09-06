# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support for ls and grep (even tho i don't use grep ???)
alias ls='ls --color=auto'
alias grep='grep --color=auto'

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
	local selected_dir=$({
        find "$HOME/.config" -type d -maxdepth 1
		echo "$HOME/Documents/Obsidian Vault"
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
cl() {
    local url=$1
    local ghq_dir="$HOME/ghq"

    # extract project name
    if [[ $url =~ git@github\.com:([^/]+)/([^/]+)\.git ]]; then
        local project_name="${match[1]}"
        local repository_name="${match[2]}"
    elif [[ $url =~ https://github\.com/([^/]+)/([^/]+)\.git ]]; then
        local project_name="${match[1]}"
        local repository_name="${match[2]}"
    elif [[ $# -ne 0 ]]; then
        local project_name="juancwu"
        local repository_name="$url"
        local url="git@github.com:juancwu/$repository_name.git"
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

# fuzzy find branches and switch to selected branch
gc() {
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

# makes it easier to spin up ngrok with static domain, pass in the port ngrok needs to listen
sngrok() {
    ngrok http --domain=hyena-merry-literally.ngrok-free.app $1
}

# Load colors if possible
autoload -U colors && colors

# Set prompt
PS1="%n@%m:%~ $ "

unset color_prompt

# setup terminal stuff
# determine initial terminal color mode
TERM_COLOR_MODE=dark
command -v asadesuka > /dev/null 2>&1
if [ $? -eq 0 ]; then
    IS_ASA=$(asadesuka -offset 30)
    if [ $IS_ASA = "true" ]; then
        TERM_COLOR_MODE=light
    fi
else
    CURRENT_HOUR=$(date +"%H")
    SEVEN_AM=7
    SEVEN_PM=19
    if [ $CURRENT_HOUR -ge $SEVEN_AM ] && [ $CURRENT_HOUR -lt $SEVEN_PM ]; then
        TERM_COLOR_MODE=light
    fi
fi
export TERM_COLOR_MODE

# set the terminal color theme
USE_TERM=alacritty
if [ $TERM_COLOR_MODE = "light" ]; then
    if [ $USE_TERM = "kitty" ]; then
        kitten @ set-colors --all "$HOME/.config/kitty/light.conf"
    fi
    if [ $USE_TERM = "alacritty" ]; then
        theme_link="$HOME/.config/alacritty/theme.toml"
        rm -rf "$theme_link"
        ln -s "$HOME/ghq/alacritty/alacritty-theme/themes/catppuccin_latte.toml" "$theme_link"
    fi
else
    if [ $USE_TERM = "kitty" ]; then
        kitten @ set-colors --all "$HOME/.config/kitty/dark.conf"
    fi
    if [ $USE_TERM = "alacritty" ]; then
        theme_link="$HOME/.config/alacritty/theme.toml"
        rm -r "$theme_link"
        ln -s "$HOME/ghq/alacritty/alacritty-theme/themes/catppuccin_mocha.toml" "$theme_link"
    fi
fi

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

command -v lazygit > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING lazygit is not installed"
else
    alias lg="lazygit"
fi

command -v ngrok > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "$WARNING ngrok is not installed"
fi
