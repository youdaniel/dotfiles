local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim"}

    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}
    use {"kabouzeid/nvim-lspinstall"}

    -- Telescope
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
    use {"nvim-telescope/telescope-fzy-native.nvim"}

    -- Autocomplete
    use {"hrsh7th/nvim-compe"}
    use {"hrsh7th/vim-vsnip"}
    use {"rafamadriz/friendly-snippets"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use {"windwp/nvim-ts-autotag"}

    -- Explorer
    use {"kyazdani42/nvim-tree.lua"}
    use {"ahmedkhalf/lsp-rooter.nvim"}

    -- Git
    use {"tpope/vim-fugitive"}
    use {"lewis6991/gitsigns.nvim"}

    -- Utilities
    use {"folke/which-key.nvim"}
    use {"wakatime/vim-wakatime"}
    use {"mbbill/undotree"}
    use {"windwp/nvim-autopairs"}
    use {"terrortylor/nvim-comment"}
    use {"JoosepAlviste/nvim-ts-context-commentstring"}
    use {"kevinhwang91/nvim-bqf"}
    use {"tpope/vim-surround"}
    use {"andymass/vim-matchup"}

    -- Dashboard
    use {"glepnir/dashboard-nvim"}

    -- Color
    use {"christianchiarulli/nvcode-color-schemes.vim"}

    -- Icons
    use {"kyazdani42/nvim-web-devicons"}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim"}
end)
