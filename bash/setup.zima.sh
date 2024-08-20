#!/bin/bash

# ---------------------------------------------------------
# THIS SCRIPT ASSUMES IT IS RUNNING WITH ROOT PRIVILEDGES.|
# ---------------------------------------------------------

# this script installs all the binaries and creates the symbolic links needed for
# a minimal setup in the zimaboard running Ubuntu 24.04

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

sudo apt update -y

# install essentials
sudo apt install wget curl git

# add github ssh key
echo "Enter GitHub SSH Key (press Ctrl+D to end)":
IFS=read -r -d '' gh_key

echo "Saving key in ~/.ssh/ghkey"
mkdir -p ~/.ssh
echo "$ghkey" > ~/.ssh/gh_key

echo "Update GitHub SSH Key permissions"
chmod 0600 ~/.ssh/gh_key

echo "Add key to ssh-agent"
eval $(ssh-agent)
ssh-add ~/.ssh/gh_key

# setup git
git config --global user.email "46619361+juancwu@users.noreply.github.com"
git config --global user.name "jc"

DOTFILES_REPO_URL=git@github.com:juancwu/dotfiles.git
DOTFILES_DIR=/opt/dotfiles
DOTFILES_GROUP=dotfiles

# clone dotfiles
mkdir -p $DOTFILES_DIR
git clone $DOTFILES_REPO_URL $DOTFILES_DIR

# create new dotfiles group
groupadd $DOTFILES_GROUP

# update dotfiles repo permissions and ownership
chown -R "root:$DOTFILES_GROUP" "$DOTFILES_DIR"
chmod 0775 "$DOTFILES_DIR"
find "$DOTFILES_DIR" -type f -exec chmod 0665 {} \;
find "$DOTFILES_DIR" -type d -exec chmod 0775 {} \;

# create ghq directory
GHQ_DIR=/opt/ghq
mkdir "$GHQ_DIR"

# create new ghq group, all repositories are going to be cloned here
# easier to share and manage repositories that multiple users depend on
GHQ_GROUP=ghq
groupadd "$GHQ_GROUP"
chown -R "root:$GHQ_GROUP" "$GHQ_DIR"
chmod 0775 "$GHQ_DIR"
find "$GHQ_DIR" -type f -exec chmod 0665 {} \;
find "$GHQ_DIR" -type d -exec chmod 0775 {} \;

# create user developer, gain access to rust, nvm, go directories
DEV_USER=developer
DEV_GROUP=$DEV_USER
useradd -m -s /bin/bash "$DEV_USER"
echo "Enter $DEV_USER password:"
passwd "$DEV_USER"

# install pnpm
if command_exists "pnpm"; then
    echo "pnpm detected, skip installation."
else
    export CARGO_HOME=/opt/.cargo
    export RUSTUP_HOME=/opt/.rustup
    mkdir -p "$CARGO_HOME"
    mkdir -p "$RUSTUP_HOME"
    chown "$DEV_USER:$DEV_GROUP" "$CARGO_HOME"
    chown "$DEV_USER:$DEV_GROUP" "$RUSTUP_HOME"
    curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# install lazygit
if command_exists "lazygit"; then
    echo "lazygit detected, skip installation."
else
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
fi

# install rustup
if command_exists "rustup"; then
	echo "rustup detected, skip installation."
else
    # make sure to install in /opt to make it available systemwide
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# install golang
if command_exists "go"; then
	echo "go detected, skip installation."
else
    GO_ARCH="linux-amd64"
    GO_VERSION="go1.23.0"
	GO_URL="https://go.dev/dl/$GO_VERSION.$GO_ARCH.tar.gz"
	wget $GO_URL
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_VERSION
	rm "$GO_VERSION.$GO_ARCH.tar.gz"
fi

# install nvm
if [ -z "$NVM_DIR" ]; then
    export NVM_DIR="/opt/.nvm"
    mkdir -p $NVM_DIR
    echo "Creating new nvm group to allow nvm management (i.e. install new node versions)"
    groupadd nvm
    (
      git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
      cd "$NVM_DIR"
      git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    ) && \. "$NVM_DIR/nvm.sh"
    chown -R "$DEV_USER:$DEV_GROUP" "$NVM_DIR"
    find "$NVM_DIR" -type f -exec chmod 0665 {} \;
    find "$NVM_DIR" -type d -exec chmod 0775 {} \;
    # post installation configuration
    NVM_LINES='
    export NVM_DIR="/opt/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    '
    # Append to .bashrc if not already present
    if ! grep -q 'export NVM_DIR="/opt/.nvm"' "$HOME/.bashrc"; then
        echo "$NVM_LINES" >> "$HOME/.bashrc"
        echo "NVM lines added to .bashrc"
    else
        echo "NVM lines already present in .bashrc"
    fi
else
	echo "nvm detected, skip installation."
fi

# install asadesuka, for checking sunset/sunrise
if command_exists "asadesuka"; then
	echo "asadesuka detected, skip installation."
else
    ASA_ARCH="Linuxx86_64"
    ASA_VERSION="v1.2.1"
	ASA_URL="https://github.com/juancwu/asadesuka/releases/download/$ASA_VERSION/asadesuka$ASA_ARCH.tar.gz"
	mkdir asa_tmp
	wget $ASA_URL -O asa_tmp/asa.tar.gz
	tar -C asa_tmp -xzf asa_tmp/asa.tar.gz
	sudo mv asa_tmp/asadesuka /usr/bin
	rm -r asa_tmp
	echo "Remember to set the ASA_LAT and ASA_LNG variables in .bashrc"
fi
