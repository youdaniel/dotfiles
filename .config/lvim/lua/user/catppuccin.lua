local M = {}

M.config = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    integrations = {
      telescope = false,
      nvimtree = {
        show_root = true,
      },
    },
  }
end

return M
