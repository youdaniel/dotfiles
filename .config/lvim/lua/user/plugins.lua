local M = {}

M.config = function()
  lvim.plugins = {
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("user.bufferline").config()
      end,
      requires = "nvim-web-devicons",
      disable = not lvim.builtin.fancy_bufferline.active,
    },
    { "AndrewRadev/splitjoin.vim", event = "BufRead" },
    {
      "andymass/vim-matchup",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    },
    {
      "goolord/alpha-nvim",
      config = function()
        require("user.dashboard").config()
      end,
      disable = not lvim.builtin.fancy_dashboard.active,
    },
    {
      "lervag/vimtex",
      config = function()
        vim.cmd "call vimtex#init()"
        require("user.vimtex").config()
      end,
      ft = "tex",
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
    { "leafOFTree/vim-vue-plugin", ft = "vue" },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("user.indent_blankline").setup()
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup "~/.local/share/nvim/dapinstall/python/bin/python"
      end,
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.colorizer").config()
      end,
      event = "BufRead",
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "InsertEnter",
      config = function()
        require("user.lsp_signature").config()
      end,
    },
    { "tpope/vim-surround", event = "BufRead" },
    {
      "unblevable/quick-scope",
      config = function()
        require("user.quickscope").config()
      end,
    },
    { "Vimjas/vim-python-pep8-indent" },
    { "wellle/targets.vim", event = "BufRead" },
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
end

return M
