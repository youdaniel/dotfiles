-- general
lvim.format_on_save = false
vim.cmd [[
  augroup select_autoformat
    autocmd BufWritePre *.{py,lua,vue} :silent lua vim.lsp.buf.formatting_sync()
  augroup END
]]
lvim.colorscheme = "dracula"
vim.opt.clipboard = "unnamed"
vim.opt.relativenumber = true
vim.opt.hlsearch = false

-- keymappings
lvim.leader_key = " "
lvim.keys.visual_mode["<C-c>"] = '"+yi'
lvim.keys.visual_mode["<C-v>"] = 'c<ESC>"+p'
lvim.keys.insert_mode["<C-v>"] = '<ESC>"+pa'

-- LSP
lvim.lsp.override = { "java" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.project.active = false
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.setup.disable_netrw = 0
lvim.builtin.nvimtree.setup.hijack_netrw = 0
vim.g.netrw_banner = 0
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_view_method = "zathura"

lvim.lsp.diagnostics.virtual_text = true
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python", "java" } }

lvim.builtin.cmp.confirm_opts.select = false

-- Additional Plugins
lvim.plugins = {
  { "AndrewRadev/splitjoin.vim" },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
  },
  { "dracula/vim" },
  {
    "lervag/vimtex",
    config = function()
      vim.cmd "call vimtex#init()"
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = "BufReadPre",
    config = function()
      require "user.blankline"
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "~/.local/share/nvim/dapinstall/python/bin/python"
    end,
  },
  { "mfussenegger/nvim-jdtls" },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("user.lsp_signature").config()
    end,
  },
  { "tamago324/lir.nvim" }, -- prevents extra buffer from appearing in bufferline with nvim /path/to/dir
  { "tpope/vim-surround" },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  { "Vimjas/vim-python-pep8-indent" },
  { "wellle/targets.vim" },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("user.spectre").config()
    end,
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufNewFile", "*.cpp", "0r ~/Documents/CP/cp.cpp | $d" },
  {
    "FileType",
    "cpp",
    "nnoremap <F9> :w <bar> !g++ -std=c++17 -Wshadow -Wall % -o %:r -g -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG <CR>",
  },
  {
    "FileType",
    "markdown",
    "set nowrap",
  },
}

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings.y = { "<cmd>%y+<CR>", "Copy All" }
lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}
