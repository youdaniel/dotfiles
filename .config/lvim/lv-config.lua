--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general

lvim.format_on_save = true
lvim.colorscheme = "dracula"
-- lvim.default_options.timeoutlen = 100
-- lvim.default_options.hlsearch = false
-- lvim.default_options.relativenumber = true

-- keymappings

lvim.leader_key = " "

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = false
lvim.builtin.galaxyline.colors.alt_bg = "#292D38"
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.auto_close = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- python
lvim.lang.python.formatter.exe = "black"
lvim.lang.python.formatter.args = { "-" }
lvim.lang.python.isort = true
-- To change enabled linters
-- https://github.com/mfussenegger/nvim-lint#available-linters
-- O.lang.python.linters = { "flake8", "pylint", "mypy", ... }

-- Additional Plugins
lvim.plugins = {
	{ "dracula/vim" },
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "tpope/vim-surround" },
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
lvim.builtin.which_key.mappings["Y"] = { "<cmd>%y+<CR>", "Copy All" }
