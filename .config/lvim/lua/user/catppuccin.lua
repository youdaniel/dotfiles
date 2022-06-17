local M = {}

M.config = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    integrations = {
      which_key = true,
      nvimtree = {
        enabled = true,
        show_root = true,
      },
    },
  }
end

return M
