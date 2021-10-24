local M = {}

M.config = function()
  lvim.keys.visual_mode["<C-c>"] = '"+yi'
  lvim.keys.visual_mode["<C-v>"] = 'c<ESC>"+p'
  lvim.keys.insert_mode["<C-v>"] = '<ESC>"+pa'
end

return M
