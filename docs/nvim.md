# Setup Neovim

> This section assumes you have cloned this repository.

1. Create a symlink of the `nvim` folder: `ln -s /path/to/repository/nvim $HOME/.config/nvim`.
2. Replace `$HOME` with the full path to your home directory.
3. Open `packer.lua` that is inside `nvim/lua/juancwu`.
4. Run command `:so`, then run `:PackerSync` or `:PackerInstall`.

Everything should be working.

## Neovim plugins

Here is a list of the plugins that I use:

- [wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) - Plugin Manager for Neovim >= 5.0
- [VonHeikemen/lsp-zero](https://github.com/VonHeikemen/lsp-zero.nvim) - All in one, sweet, sweet LSP configurations.
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
