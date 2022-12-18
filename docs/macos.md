# MacOS Setup

Follow the steps below to configure the dotfiles on macOS.

## Requirements

### 1. Install Homebrew

- [Homebrew](https://brew.sh/) - Package manager for macOS.

After installing Homebrew, make sure to save its path somewhere using `which brew`. We are going to need it later to add it to path for `fish`.

### 2. Install Fish

```bash
brew install fish
which fish
```

For more info:

- [Fish](https://fishshell.com/) - fish is a smart and user-friendly command line shell for Linux, macOS, and the rest of the family.


Here is a list of [Fish customizations](/fish.md).

#### Make fish the default shell

```bash
chsh -s $(which fish)
```

### 3. Install iTerm2

```fish
brew install iTerm2 --cask
```

Setup iTerm2 from json file. [Download](./files/iterm-profile.json)

### 4. Install Numi

Calculator and conversion application.

```fish
brew install numi --cask
```

### 5. Install Min browser

Minimalist browser

```fish
brew install min --cask
```

### 6. Install Karabiner-Elements

Keybinding at system wide level for macOS. We want this for the sweet `ctrl+[` -> `esc` and `ctrl+h/j/k/l` -> `arrow keys`.

```fish
brew install karabiner-elements --cask
```

### 7. Install Neovim

Neovim is an extension of vim that supports Lua scripting for configurations and plugins.

```fish
brew install neovim
```

After installing `neovim` check if the version is `>= 0.9.0`.
This is important because `treesitter` seems to be having problems with earlier versions.
As of now the stable version is `0.8.1` and it is causing problems.


If the version is not `>= 0.9.0`, follow these steps to install a compatible version:

1. Download [nvim-macos.tar.gz](https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz).
2. Run `xattr -c ./nvim-macos.tar.gz` (to avoid "unknown developer" warning)
3. Extract: `tar xzvf nvim-macos.tar.gz`
4. Run `./nvim-macos/bin/nvim`

Let's create a symlink to the binary file:
`sudo ln -s /path/where/it/is/located/bin/nvim /usr/local/bin/nvim`. This will allow us to run `nvim` without moving the binary to `usr/local/bin`.

Now it is time to [setup Neovim](/nvim.md).
