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
lvim.lsp.override = { "jdtls", "vuels" }
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
lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python", "java", "vue" } }
lvim.builtin.treesitter.context_commentstring.enable = true

-- nvimtree
lvim.builtin.nvimtree.setup.view.auto_resize = true
lvim.builtin.nvimtree.setup.auto_close = false

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
lvim.lang.python.formatters = { { exe = "black" }, { exe = "isort" } }
lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.rust.formatters = { { exe = "rustfmt" } }
formatters.setup { { exe = "prettier", filetypes = { "javascript", "typescript", "vue" } } }

-- disable default formatters for tsserver and jsonls
lvim.lsp.on_attach_callback = function(client, _)
  if client.name == "tsserver" or client.name == "jsonls" or client.name == "volar" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
end

-- Additional Plugins
lvim.plugins = {
  { "AndrewRadev/splitjoin.vim" },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
  },
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
  { "JoosepAlviste/nvim-ts-context-commentstring" },
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
  { "leafOFTree/vim-vue-plugin" },
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
  { "youdaniel/dracula" },
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
