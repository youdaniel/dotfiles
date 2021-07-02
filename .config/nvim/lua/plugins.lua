local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then return end

packer.init {
    -- compile_path = vim.fn.stdpath('data')..'/site/pack/loader/start/packer.nvim/plugin/packer_compiled.vim',
    compile_path = require("packer.util").join_paths(vim.fn.stdpath('config'),
                                                     'plugin',
                                                     'packer_compiled.vim'),
    git = {clone_timeout = 300},
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    }
}

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim"}

    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"tjdevries/astronauta.nvim"}
    use {"nvim-telescope/telescope.nvim", config = [[require('lv-telescope')]]}
    use {"nvim-telescope/telescope-fzy-native.nvim", event = "BufRead"}

    -- Autocomplete
    use {
        "hrsh7th/nvim-compe",
        config = function()
            require("lv-compe").config()
        end
    }

    use {"hrsh7th/vim-vsnip", event = "InsertEnter"}
    use {"rafamadriz/friendly-snippets", event = "InsertEnter"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    -- Explorer
    use {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("lv-nvimtree").config()
        end
    }
    -- use {
    --     "ahmedkhalf/lsp-rooter.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("lsp-rooter").setup()
    --     end
    -- }

    -- Git
    use {"tpope/vim-fugitive"}
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("lv-gitsigns").config()
        end,
        event = "BufRead"
    }

    -- Utilities
    use {"folke/which-key.nvim"}
    use {"wakatime/vim-wakatime"}
    use {"mbbill/undotree"}

    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        config = function()
            require 'lv-autopairs'
        end
    }
    -- Comments
    use {
        "terrortylor/nvim-comment",
        config = function()
            require('nvim_comment').setup()
        end
    }
    use {"JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead"}
    use {"kevinhwang91/nvim-bqf", event = "BufRead"}
    use {"tpope/vim-surround"}

    -- Matchup
    use {
        'andymass/vim-matchup',
        event = "CursorMoved",
        config = function()
            require('lv-matchup').config()
        end
    }

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim"}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}
end)
