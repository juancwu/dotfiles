# Dotfiles Readme

The configurations in this repository are highly inspired by and referenced from [craftzdog](https://github.com/craftzdog/dotfiles-public).

# Terminal Colourscheme

## Basic Colours

- Foreground: #839496
- Background: #001f27
- Bold: #93a1a1
- Links: #005bbb
- Selection: #073642
- Selected text: #93a1a1

## ANSI Colours

### Normal

- Black: #073642
- Red: #dc322f
- Green: #859900
- Yellow: #b58900
- Blue: #268bd2
- Magenta: #d33682
- Cyan: #2aa198
- White: #eee8d5

### Bright

- Black: #002b36
- Red: #cb4b16
- Green: #586e75
- Yellow: #657b83
- Blue: #839496
- Magenta: #6c71c4
- Cyan: #93a1a1
- White: #fdf6e3

## Cursor Colours

- Cursor: #839496
- Cursor text: #073642

# Setup

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

Neovim is an extension of vim that supports Lua scripting for configurations and plugins.

```fish
sudo apt install neovim
```

After installing neovim, we want to install all the language servers needed and formatters before installing plugins to avoid any problems.

---

#### Language Servers

For information on specific configuration head to [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

**Typescript**: [https://github.com/typescript-language-server/typescript-language-server](https://github.com/typescript-language-server/typescript-language-server)

**Golang**: [https://github.com/golang/tools/tree/master/gopls](https://github.com/golang/tools/tree/master/gopls)

**Clangd**: [https://clangd.llvm.org/installation.html](https://clangd.llvm.org/installation.html)

**Pyright**: [https://github.com/microsoft/pyright](https://github.com/microsoft/pyright)

**Tailwindcss**: [https://github.com/tailwindlabs/tailwindcss-intellisense](https://github.com/tailwindlabs/tailwindcss-intellisense)

---

#### Formatter

---

**Prettierd**: [https://github.com/fsouza/prettierd](https://github.com/fsouza/prettierd)

---

#### Neovim plugins

- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) - Plugin Manager for Neovim >= 5.0
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - A blazing fast and easy to configure Neovim statusline written in Lua.
- [tjdevries/colorbuddy.nvim](https://github.com/tjdevries/colorbuddy.nvim) - A colourscheme helper for Neovim.
- [svrana/neosolarized.nvim](https://github.com/svrana/neosolarized.nvim) - A truecolour, solarized dark colourscheme using.
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Configurations for Neovim builtin LSP server.
- [onsails/lspkind-nvim](https://github.com/onsails/lspkind.nvim) - vscode-like pictograms.
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion engine plugin for neovim written in Lua.
  - [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - nvim-cmp source for buffer words.
  - hrsh7th/cmp-nvim-lsp - No link for this one, but it is needed
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippets for the LSP popups.
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Neovim treesitter for incremental syntax highlighting.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - A super powerful autopair plugin for Neovim that supports multiple characters.
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Use treesitter to autoclose and autorename html tag.
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - telescope.nvim is a highly extendable fuzzy finder over lists. Built on the latest awesome features from neovim core.
- [nvim-telescope/telescope-file-browser](https://github.com/nvim-telescope/telescope-file-browser.nvim) - telescope-file-browser.nvim is a file browser extension for telescope.nvim. It supports sunchronized creation, deletion, renaming, and moving of files and folders powered by telescope.nvim and plenary.nvim.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - A lua fork of vim-devicons. This plugin provides the same icons as well as colours for each icon.
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - Markdown preview
- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) - A snazzy buffer line.
- [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) - A high-performance colour highlighter for Neovim which has no external dependencies.
- [glepnir/lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) - A light-weight lsp plugin based on Neovim's builtin lsp with a highly performant UI.
- [ray-x/lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) - Show function signature when you type.
- [jose-elias-alvares/null-ls.nvim](https://github.com/ray-x/lsp_signature.nvim) - Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - mason-lspconfig bridges mason.nvim with the lspconfig plugin.

# Fish Shell Customization

This section defines a list of plugins used to customize fish.

- [Tide](https://github.com/IlanCosman/tide) - The ultimate Fish prompt.
- [Fisher](https://github.com/jorgebucaran/fisher) - Manage functions, completions, bindings, and snippets from the command line.
- [Exa](https://the.exa.website/) - New gen `ls`.
- [Z](https://github.com/jethrokuan/z) - tracks the directories you visit and jump between them.
- [Peco](https://github.com/peco/peco) - Filterting tool.
- [Llama](https://github.com/antonmedv/llama) - Terminal file manager.
- [ghq](https://github.com/x-motemen/ghq) - Manage remote repository clones.

testing sign commits
