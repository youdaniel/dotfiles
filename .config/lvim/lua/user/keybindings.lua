local M = {}

M.config = function()
  lvim.keys.visual_mode["<C-c>"] = '"+yi'
  lvim.keys.visual_mode["<C-v>"] = 'c<ESC>"+p'
  lvim.keys.insert_mode["<C-v>"] = '<ESC>"+pa'

  lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
  }
end

return M
