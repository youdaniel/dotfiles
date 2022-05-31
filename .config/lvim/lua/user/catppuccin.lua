local M = {}

M.config = function()
  local catppuccin = require "catppuccin"
  catppuccin.setup {
    integrations = {
      which_key = true,
    },
  }
end

return M
