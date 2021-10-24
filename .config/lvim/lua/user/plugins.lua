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
      event = "CursorMoved",
      config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    {
      "lervag/vimtex",
      config = function()
        vim.cmd "call vimtex#init()"
        require("user.vimtex").config()
      end,
    },
    {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      ft = "markdown",
    },
    { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" },
    {
      "kevinhwang91/nvim-bqf",
      event = "BufRead",
    },
    {
      "kkoomen/vim-doge",
      run = ":call doge#install()",
      config = function()
        require("user.doge").config()
      end,
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
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
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
