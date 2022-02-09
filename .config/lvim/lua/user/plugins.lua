local M = {}

M.config = function()
  lvim.plugins = {
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("user.neoclip").config()
      end,
    },
    { "AndrewRadev/splitjoin.vim", event = "BufRead" },
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
      "danymat/neogen",
      config = function()
        require("neogen").setup {
          enabled = true,
        }
      end,
      requires = "nvim-treesitter/nvim-treesitter",
    },
    { "dracula/vim" },
    {
      "goolord/alpha-nvim",
      config = function()
        require("user.dashboard").config()
      end,
      disable = not lvim.builtin.fancy_dashboard.active,
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
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
      "j-hui/fidget.nvim",
      config = function()
        require("user.fidget_spinner").config()
      end,
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
      ft = "python",
    },
    { "mfussenegger/nvim-jdtls", ft = "java" },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("user.colorizer").config()
      end,
      event = "BufRead",
    },
    { "ray-x/lsp_signature.nvim", event = "InsertEnter" },
    { "tpope/vim-surround", event = "BufRead" },
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    { "wellle/targets.vim", event = "BufRead" },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup {
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "tsx",
            "jsx",
            "xml",
          },
        }
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
