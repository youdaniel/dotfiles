local M = {}

M.config = function()
  vim.opt.clipboard = "unnamed"
  vim.opt.relativenumber = true
  vim.opt.hlsearch = false
  vim.opt.fillchars = {
    eob = " ", -- suppress ~ at EndOfBuffer
  }

  -- Cursorline highlighting control
  --  Only have it on in the active buffer
  vim.opt.cursorline = true -- Highlight the current line
  if vim.fn.has "nvim-0.7" ~= 0 then
    local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
    vim.api.nvim_create_autocmd("WinLeave", {
      group = group,
      callback = function()
        vim.opt_local.cursorline = false
      end,
    })
    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      callback = function()
        if vim.bo.filetype ~= "alpha" then
          vim.opt_local.cursorline = true
        end
      end,
    })
  end
end

return M
