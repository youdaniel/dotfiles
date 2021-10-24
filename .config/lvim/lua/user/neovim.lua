local M = {}

M.config = function()
  vim.opt.clipboard = "unnamed"
  vim.opt.relativenumber = true
  vim.opt.hlsearch = false
end

return M
