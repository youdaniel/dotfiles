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
      "andymass/vim-matchup",
      event = "BufReadPost",
      config = function()
        vim.g.matchup_enabled = 1
        vim.g.matchup_surround_enabled = 1
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
    {
      "kevinhwang91/nvim-bqf",
      event = "WinEnter",
    },
    {
      "kylechui/nvim-surround",
      event = "BufReadPost",
      config = function()
        require("nvim-surround").setup()
      end,
    },
    { "leafOFTree/vim-vue-plugin", ft = "vue" },
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
      config = function()
        require("user/lsp_signature").config()
      end,
    },
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
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
end

return M
