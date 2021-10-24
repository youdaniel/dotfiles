local M = {}

M.config = function()
  lvim.builtin.dashboard.active = true
  lvim.builtin.terminal.active = true
  lvim.builtin.project.active = false
  lvim.builtin.dap.active = true

  -- LSP
  local function indexOf(array, value)
    for i, v in ipairs(array) do
      if v == value then
        return i
      end
    end
    return nil
  end
  table.remove(lvim.lsp.override, indexOf(lvim.lsp.override, "volar"))
  vim.list_extend(lvim.lsp.override, { "vuels" })
  lvim.lsp.diagnostics.virtual_text = true
  lvim.lsp.automatic_servers_installation = false

  -- Formatters
  local formatters = require "lvim.lsp.null-ls.formatters"
  lvim.lang.python.formatters = { { exe = "black" }, { exe = "isort" } }
  lvim.lang.lua.formatters = { { exe = "stylua" } }
  lvim.lang.rust.formatters = { { exe = "rustfmt" } }
  formatters.setup { { exe = "prettier", filetypes = { "javascript", "typescript", "vue" } } }

  -- NvimTree
  lvim.builtin.nvimtree.setup.view.auto_resize = true
  lvim.builtin.nvimtree.setup.auto_close = false

  -- Telescope
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
    },
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
  }

  -- Treesitter
  lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.highlight.disable = {}
  lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python", "java", "vue" } }
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.matchup = true

  -- WhichKey
  lvim.builtin.which_key.mappings.y = { "<cmd>%y+<CR>", "Copy All" }
  lvim.builtin.which_key.mappings["r"] = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  }
end

return M
