#!/bin/bash

# this script installs all the binaries and creates the symbolic links needed for
# a minimal setup

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# install aur helper, paru
if command_exists "paru"; then
	echo "paru AUR helper detected, skip installation."
else
	sudo pacman -S --needed base-devel
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	cd -
fi

# install essentials
echo "Installing essentials..."
sudo pacman -Sy curl wget neovim fzf bat ripgrep git
echo "Setup symlink for neovim configuration"
ln -s ~/ghq/juancwu/dotfiles/nvim ~/.config/nvim

# setup git
git config --global user.email "46619361+juancwu@users.noreply.github.com"
git config --global user.name "jc"

# install gh cli
if command_exists "gh"; then
    echo "gh detected, skip installation."
else
    sudo pacman -S github-cli
fi

# install pnpm
if command_exists "pnpm"; then
    echo "pnpm detected, skip installation."
else
    curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# install lazygit
if command_exists "lazygit"; then
    echo "lazygit detected, skip installation."
else
    sudo pacman -S lazygit
fi

# install rustup
if command_exists "rustup"; then
	echo "rustup detected, skip installation."
else
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# install golang
if command_exists "go"; then
	echo "go detected, skip installation."
else
	GO_VERSION="go1.23.0.linux-amd64.tar.gz"
	GO_URL="https://go.dev/dl/$GO_VERSION"
	wget $GO_URL
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_VERSION
	rm $GO_VERSION
fi

# install nvm
if [ -z "$NVM_DIR" ]; then
	paru -S nvm
else
	echo "nvm detected, skip installation."
fi

# install asadesuka, for checking sunset/sunrise
if command_exists "asadesuka"; then
	echo "asadesuka detected, skip installation."
else
	ASA_URL="https://github.com/juancwu/asadesuka/releases/download/v1.2.0/asadesukaLinuxx86_64.tar.gz"
	mkdir asa_tmp
	wget $ASA_URL -O asa_tmp/asa.tar.gz
	tar -C asa_tmp -xzf asa_tmp/asa.tar.gz
	sudo mv asa_tmp/asadesuka /usr/bin
	rm -r asa_tmp
	echo "Remember to set the ASA_LAT and ASA_LNG variables in .bashrc"
fi
