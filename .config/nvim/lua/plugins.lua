local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'tjdevries/colorbuddy.nvim' -- use to configure neovim theme
    use 'neovim/nvim-lspconfig' -- configuration presets for LSP
    -- use 'bbenzikry/snazzybuddy.nvim' -- colorscheme
    use {
        'svrana/neosolarized.nvim',
        requires = { 'tjdevries/colorbuddy.nvim' }
    } -- another colorscheme
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
    use 'hrsh7th/nvim-cmp' -- auto complete
    use 'L3MON4D3/LuaSnip' -- snippets
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end
    }

    -- tabs
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*"
    }

    -- highlights hexcolor string
    use 'norcalli/nvim-colorizer.lua'

    -- LSP UI
    use 'glepnir/lspsaga.nvim'

    -- Signature help
    use 'ray-x/lsp_signature.nvim'

    -- linter/formatter
    use 'jose-elias-alvarez/null-ls.nvim'
    -- mason, allows easy manage external editor toolin such as LSP servers, DAP servers, linters, and formatters
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
end)
