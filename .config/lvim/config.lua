-- general
lvim.format_on_save = false
vim.cmd [[
  augroup select_autoformat
    autocmd BufWritePre *.{py,lua} :silent lua vim.lsp.buf.formatting_sync()
  augroup END
]]
lvim.colorscheme = "dracula"
vim.opt.relativenumber = true
vim.opt.hlsearch = false

-- keymappings
lvim.leader_key = " "
lvim.keys.insert_mode[";;"] = '<C-r>"'

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
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_view_method = "zathura"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.lsp.diagnostics.virtual_text = true
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.autotag.enable = true

-- Additional Plugins
lvim.plugins = {
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
    "lukas-reineke/indent-blankline.nvim",
    -- event = "BufReadPre",
    config = function()
      require "user.blankline"
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
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
  { "wellle/targets.vim" },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
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
lvim.builtin.which_key.mappings.y = { "<cmd>%y+<CR>", "Copy All" }
