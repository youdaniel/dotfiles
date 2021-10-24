local M = {}

M.config = function()
  vim.g.vimtex_compiler_progname = "nvr"
  vim.g.vimtex_quickfix_enabled = 0
  vim.g.vimtex_view_method = "zathura"
end

return M
