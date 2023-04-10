-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Copy Paste
map("n", "<leader>y", "<CMD>%y+<CR>", { desc = "Copy All" })

map("v", "<C-c>", '"+yi')
map("v", "<C-v>", 'c<ESC>"+p')
map("i", "<C-v>", '<ESC>"+pa')

-- Move code in visual mode
map("v", "J", ":move '>+1<CR>gv-gv", { desc = "Move down" })
map("v", "K", ":move '<-2<CR>gv-gv", { desc = "Move up" })
for _, mode in ipairs({ "n", "i", "v" }) do
  for _, lhs in ipairs({ "<A-j>", "<A-k>" }) do
    vim.api.nvim_del_keymap(mode, lhs)
  end
end
