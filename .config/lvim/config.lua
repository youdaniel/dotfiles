-- General
lvim.leader = " "
lvim.format_on_save = true
lvim.colorscheme = "dracula"
require("user.neovim").config()

-- Autocommands
require("user.autocommands").config()

-- Builtin
require("user.builtin").config()

-- Keymappings
require("user.keybindings").config()

-- Plugins
require("user.plugins").config()
