local M = {}

M.config = function()
  lvim.plugins = {
    {
      "AckslD/nvim-neoclip.lua",
      lazy = true,
      keys = "<leader>Y",
      config = function()
        require("user.neoclip").config()
      end,
    },
    {
      "andymass/vim-matchup",
      event = "BufReadPost",
      init = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("user.colorscheme").config()
        lvim.colorscheme = "catppuccin-mocha"
      end,
    },
    {
      "danymat/neogen",
      lazy = true,
      config = function()
        require("neogen").setup {}
      end,
      dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app && npm install",
      ft = "markdown",
    },
    {
      "lervag/vimtex",
      init = function()
        require("user.vimtex").init()
      end,
      config = function()
        vim.cmd "call vimtex#init()"
      end,
      ft = "tex",
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("user.fidget_spinner").config()
      end,
    },
    { "kevinhwang91/nvim-bqf", event = "WinEnter" },
    {
      "kylechui/nvim-surround",
      event = { "BufReadPost", "BufNew" },
      config = function()
        require("nvim-surround").setup()
      end,
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
      "norcalli/nvim-colorizer.lua",
      event = "BufReadPre",
      config = function()
        require("user.colorizer").config()
      end,
    },
    {
      "ray-x/lsp_signature.nvim",
      event = { "BufRead", "BufNew" },
      config = function()
        require("user/lsp_signature").config()
      end,
    },
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "windwp/nvim-ts-autotag", event = "BufReadPost" },
    {
      "windwp/nvim-spectre",
      lazy = true,
      config = function()
        require("user.spectre").config()
      end,
    },
  }
end

return M
