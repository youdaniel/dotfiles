-- general
lvim.format_on_save = true
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
lvim.lsp.override = { "jdtls" }
lvim.lsp.diagnostics.virtual_text = true

-- builtin
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.project.active = false
lvim.builtin.dap.active = true

-- vimtex
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_view_method = "zathura"

-- treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python", "java" } }

-- cmp
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local function T(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local is_emmet_active = function()
  local clients = vim.lsp.buf_get_clients()

  for _, client in pairs(clients) do
    if client.name == "emmet_ls" then
      return true
    end
  end
  return false
end

lvim.builtin.cmp.confirm_opts.select = false
lvim.builtin.cmp.mapping["<Tab>"] = require("cmp").mapping(function()
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(T "<down>", "n")
  elseif require("luasnip").expand_or_jumpable() then
    vim.fn.feedkeys(T "<Plug>luasnip-expand-or-jump", "")
  elseif check_backspace() then
    vim.fn.feedkeys(T "<Tab>", "n")
  elseif is_emmet_active() then
    return vim.fn["cmp#complete"]()
  elseif vim.b.doge_interactive then
    vim.fn.feedkeys(T "<Plug>(doge-comment-jump-forward)", "")
  else
    vim.fn.feedkeys(T "<Tab>", "n")
  end
end, {
  "i",
  "s",
})
lvim.builtin.cmp.mapping["<S-Tab>"] = require("cmp").mapping(function(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(T "<up>", "n")
  elseif require("luasnip").jumpable(-1) then
    vim.fn.feedkeys(T "<Plug>luasnip-jump-prev", "")
  elseif vim.b.doge_interactive then
    vim.fn.feedkeys(T "<Plug>(doge-comment-jump-backward)", "")
  else
    fallback()
  end
end, {
  "i",
  "s",
})

-- nvimtree
lvim.builtin.nvimtree.setup.view.auto_resize = true
lvim.builtin.nvimtree.setup.auto_close = false

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
    "kkoomen/vim-doge",
    config = function()
      require "user.doge"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
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
    config = function()
      require("nvim-ts-autotag").setup()
    end,
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
