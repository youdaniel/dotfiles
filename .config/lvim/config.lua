-- general
lvim.format_on_save = false
vim.cmd[[
  augroup select_autoformat
    autocmd BufWritePre *.{py,lua} :silent lua vim.lsp.buf.formatting_sync()
  augroup END
]]
lvim.colorscheme = "dracula"
vim.opt.relativenumber = true

-- keymappings
lvim.leader_key = " "

-- LSP
lvim.lsp.override = { "java" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.project.active = false
lvim.builtin.dap.active = false
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.netrw_banner = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
	{ "dracula/vim" },
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
  {
    "tamago324/lir.nvim",
    config = function()
      require "user.lir"
    end,
  },
	{ "tpope/vim-surround" },
	{ "mfussenegger/nvim-jdtls" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{ "BufNewFile", "*.cpp", "0r ~/Documents/CP/cp.cpp" },
	{
		"FileType",
		"cpp",
		"nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>",
	},
}

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings.Y = { "<cmd>%y+<CR>", "Copy All" }
lvim.builtin.which_key.mappings.f = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }
