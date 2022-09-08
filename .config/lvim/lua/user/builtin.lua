local M = {}

M.config = function()
  local lb = lvim.builtin
  local kind = require "user.lsp_kind"

  -- CMP
  -- =========================================
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local neogen = require "neogen"
  local lccm = require("lvim.core.cmp").methods ---@diagnostic disable-line
  lb.cmp.mapping["<Tab>"] = cmp.mapping(function(fallback)
    if neogen.jumpable() then
      lccm.feedkeys("<cmd>lua require('neogen').jump_next()<CR>", "")
    elseif cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif lccm.jumpable() then
      luasnip.jump(1)
    elseif lccm.check_backspace() then
      fallback()
    elseif lccm.is_emmet_active() then
      return vim.fn["cmp#complete"]()
    else
      fallback()
    end
  end, {
    "i",
    "s",
  })
  lb.cmp.formatting.kind_icons = kind.cmp_kind

  -- Dashboard
  -- =========================================
  lvim.builtin.alpha.mode = "custom"
  local alpha_opts = require("user.dashboard").config()
  lvim.builtin.alpha["custom"] = { config = alpha_opts }

  -- DAP
  -- =========================================
  lb.dap.active = false

  -- Formatters
  -- =========================================
  local formatters = require "lvim.lsp.null-ls.formatters"
  formatters.setup {
    { exe = "black", filetypes = { "python" } },
    { exe = "isort", filetypes = { "python" } },
    { exe = "rustfmt", filetypes = { "rust" } },
    { exe = "stylua", filetypes = { "lua" } },
    {
      exe = "prettierd",
      filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
      },
    },
  }

  -- LSP
  -- =========================================
  lvim.builtin.global_statusline = true

  -- LSP
  -- =========================================
  local function indexOf(array, value)
    for i, v in ipairs(array) do
      if v == value then
        return i
      end
    end
    return nil
  end

  table.remove(lvim.lsp.automatic_configuration.skipped_servers, indexOf(lvim.lsp.override, "volar"))
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })
  lvim.lsp.diagnostics.virtual_text = true
  lvim.lsp.installer.setup.automatic_installation = false

  -- NvimTree
  -- =========================================
  lb.nvimtree.setup.actions.open_file.resize_window = true
  lb.nvimtree.setup.renderer.icons.glyphs = kind.nvim_tree_icons
  lb.nvimtree.setup.renderer.icons.show = {
    git = true,
    folder = true,
    file = true,
    folder_arrow = true,
  }

  -- Project
  -- =========================================
  lb.project.active = false

  -- Telescope
  -- =========================================
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
  -- =========================================
  lb.terminal.active = true

  -- Treesitter
  -- =========================================
  local languages = vim.tbl_flatten {
    { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "d", "dart" },
    { "dockerfile", "elixir", "elm", "erlang", "fennel", "fish", "go" },
    { "gomod", "graphql", "hcl", "help", "html", "java", "javascript", "jsdoc" },
    { "json", "jsonc", "julia", "kotlin", "latex", "ledger", "lua", "make" },
    { "markdown", "nix", "ocaml", "perl", "php", "python", "query", "r" },
    { "regex", "rego", "ruby", "rust", "scala", "scss", "solidity", "swift" },
    { "teal", "toml", "tsx", "typescript", "vim", "vue", "yaml", "zig" },
  }
  lb.treesitter.ensure_installed = languages
  lb.treesitter.ignore_install = { "haskell" }
  lb.treesitter.highlight.disable = {}
  lb.treesitter.indent = { enable = true, disable = { "yaml", "python", "java", "vue" } }
  lb.treesitter.context_commentstring.enable = true
  lb.treesitter.matchup.enable = true
end

return M
