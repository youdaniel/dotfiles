return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },

  -- disable motion plugins
  { "ggandor/flit.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },

  -- dashboard
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "Function"
        button.opts.hl_shortcut = "Number"
      end
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      worktrees = {
        {
          toplevel = vim.env.HOME,
          gitdir = vim.env.HOME .. "/.cfg",
        },
      },
    },
  },

  -- neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window.mappings = vim.tbl_extend("force", opts.window.mappings, { ["l"] = "open" })
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local m = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
      opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, m)
      opts.defaults.mappings.n = vim.tbl_extend("force", opts.defaults.mappings.n, m)
    end,
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ignore_install = { "help" }
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
