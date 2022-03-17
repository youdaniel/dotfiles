-- General
lvim.leader = " "
lvim.format_on_save = {
  pattern = "*.{py,rs,lua,html,css,js,ts,vue}",
}
lvim.colorscheme = "dracula"
require("user.neovim").config()

lvim.builtin.fancy_dashboard = { active = true }
lvim.builtin.fancy_statusline = { active = true }

-- Autocommands
require("user.autocommands").config()

-- Builtin
require("user.builtin").config()

-- Keymappings
require("user.keybindings").config()

-- Plugins
require("user.plugins").config()

-- StatusLine
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end
