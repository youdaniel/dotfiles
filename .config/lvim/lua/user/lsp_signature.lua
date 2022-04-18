local M = {}

M.config = function()
  local status_ok, sig = pcall(require, "lsp_signature")
  if not status_ok then
    return
  end

  local cfg = {
    floating_window = false,
    hint_enable = true,
    max_width = 120,
    toggle_key = "<C-x>",
  }
  sig.setup(cfg)
end

return M
