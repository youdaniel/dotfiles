local M = {}

M.config = function()
  local status_ok, lsp_signature = pcall(require, "lsp_signature")
  if not status_ok then
    return
  end

  lsp_signature.setup {
    toggle_key = "<C-x>",
  }
end

return M
