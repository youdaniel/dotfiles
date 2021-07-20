--[[
O is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general

O.format_on_save = true
O.completion.autocomplete = true
O.colorscheme = "dracula"
O.default_options.wrap = false
O.default_options.timeoutlen = 100
O.default_options.hlsearch = false
O.default_options.relativenumber = true

-- keymappings

O.leader_key = " "

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
O.plugin.dashboard.active = true
O.plugin.terminal.active = false
O.plugin.zen.active = false
O.plugin.galaxyline.colors.alt_bg = "#292D38"
O.plugin.nvimtree.side = "left"
O.plugin.nvimtree.show_icons.git = 0
-- O.plugin.telescope.defaults.path_display = {}

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "maintained"
O.treesitter.ignore_install = { "haskell" }
O.treesitter.highlight.enabled = true

-- python
O.lang.python.formatter.exe = "black"
O.lang.python.formatter.args = { "-" }
O.lang.python.isort = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.analysis.use_library_code_types = true
-- To change enabled linters
-- https://github.com/mfussenegger/nvim-lint#available-linters
-- O.lang.python.linters = { "flake8", "pylint", "mypy", ... }

-- javascript
O.lang.tsserver.linter = nil

-- Additional Plugins
O.user_plugins = {
  { "dracula/vim" },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
O.user_autocommands = {
  { "BufNewFile", "*.cpp", "0r ~/Documents/CP/cp.cpp" },
  {
    "FileType",
    "cpp",
    "nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>",
  },
}

-- Additional Leader bindings for WhichKey
O.user_which_key = {
  ["Y"] = { "<cmd>%y+<CR>", "Copy All" },
}
