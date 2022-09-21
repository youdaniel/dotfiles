local M = {}

M.config = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    integrations = {
      cmp = true,
      fidget = true,
      lsp_trouble = true,
      telescope = true,
      treesitter = true,
      nvimtree = {
        show_root = true,
      },
    },
  }
end

return M
