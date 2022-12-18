# Linux Setup

Follow the steps below to configure the dotfiles on Ubuntu.

## Requirements

### 1. Install Fish

Visit [https://fishshell.com/](https://fishshell.com/) and follow the instructions to install fish on Ubuntu.

Alternatively, follow these instructions for installing in Ubuntu.

```bash
sudo add-apt-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
```

Verify fish has been installed.

```bash
which fish
```

Here is the list of [Fish customizations](/docs/fish.md).

#### Make fish the default shell

```bash
chsh -s $(which fish)
```

### 2. Install Min browser

Minimalist browser

Use the below command if running on Ubuntu:

```fish
sudo dpkg -i /path/to/download
```

If not, visit [https://minbrowser.org/](https://minbrowser.org/).

### 3. Install Neovim

Install `v0.9.0` for all the plugins to work. The debian package can be download with this link: (This is not a stable release but the latest `v0.8.1` is showing problems with treesitter)

- https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb

After downloading the package, use the command below to install:

```bash
sudo apt install ./nvim-linux64.deb
```

> Note: This installation assumes that you are using Ubuntu.

---

#### Install Plugin Manager For Neovim

We are using [packer](https://github.com/wbthomason/packer.nvim) as the plugin manager.

Copy the code below to install:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Now it is time to [setup Neovim](/docs/nvim.md).
