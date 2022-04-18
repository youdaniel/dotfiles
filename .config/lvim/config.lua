-- General
lvim.leader = " "
lvim.format_on_save = {
  pattern = "*.{py,rs,lua,html,css,js,jsx,ts,tsx,vue,c}",
}
lvim.colorscheme = "dracula"
require("user.neovim").config()

-- Plugins
require("user.plugins").config()

-- Builtin
require("user.builtin").config()

-- Autocommands
require("user.autocommands").config()

-- Keymappings
require("user.keybindings").config()

-- StatusLine
require("user.lualine").config()
