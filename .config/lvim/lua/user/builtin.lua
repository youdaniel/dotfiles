local M = {}

M.config = function()
  local lb = lvim.builtin

  -- CMP
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local lccm = require("lvim.core.cmp").methods ---@diagnostic disable-line
  lb.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif lccm.jumpable() then
      luasnip.jump(1)
    elseif lccm.check_backspace() then
      fallback()
    elseif lccm.is_emmet_active() then
      return vim.fn["cmp#complete"]()
    elseif vim.b.doge_interactive then
      lccm.feedkeys("<Plug>(doge-comment-jump-forward)", "")
    else
      fallback()
    end
  end, {
    "i",
    "s",
  })
  lb.cmp.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif lccm.jumpable(-1) then
      luasnip.jump(-1)
    elseif vim.b.doge_interactive then
      lccm.feedkeys("<Plug>(doge-comment-jump-backward)", "")
    else
      fallback()
    end
  end, {
    "i",
    "s",
  })

  -- Dashboard
  lb.dashboard.active = true

  -- DAP
  lb.dap.active = true

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
  vim.list_extend(lvim.lsp.override, { "jdtls", "vuels" })
  lvim.lsp.diagnostics.virtual_text = true
  lvim.lsp.automatic_servers_installation = false

  -- Formatters
  local formatters = require "lvim.lsp.null-ls.formatters"
  lvim.lang.python.formatters = { { exe = "black" }, { exe = "isort" } }
  lvim.lang.lua.formatters = { { exe = "stylua" } }
  lvim.lang.rust.formatters = { { exe = "rustfmt" } }
  formatters.setup { { exe = "prettier", filetypes = { "javascript", "typescript", "vue" } } }

  -- NvimTree
  lb.nvimtree.setup.view.auto_resize = true
  lb.nvimtree.setup.auto_close = false

  -- Project
  lb.project.active = false

  -- Telescope
  local actions = require "telescope.actions"
  lb.telescope.defaults.mappings = {
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

  -- Terminal
  lb.terminal.active = true

  -- Treesitter
  lb.treesitter.ensure_installed = "maintained"
  lb.treesitter.ignore_install = { "haskell" }
  lb.treesitter.highlight.disable = {}
  lb.treesitter.indent = { enable = true, disable = { "yaml", "python", "java", "vue" } }
  lb.treesitter.context_commentstring.enable = true
  lb.treesitter.matchup = true

  -- WhichKey
  lb.which_key.mappings.y = { "<cmd>%y+<CR>", "Copy All" }
  lb.which_key.mappings["r"] = {
    name = "Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  }
end

return M
