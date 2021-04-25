vim.g.dashboard_custom_header = {
    '                 _..._                                                                           ',
    '               .\'   (_`.    _                         __     ___           ',
    '              :  .      :  | |   _   _ _ __   __ _ _ _\\ \\   / (_)_ __ ___  ',
    '              :)    ()  :  | |  | | | | \'_ \\ / _` | \'__\\ \\ / /| | \'_ ` _ \\ ',
    '              `.   .   .\'  | |__| |_| | | | | (_| | |   \\ V / | | | | | | |',
    '                `-...-\'    |_____\\__,_|_| |_|\\__,_|_|    \\_/  |_|_| |_| |_|'
}

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    e = {description = {'  Settings           '}, command = ':e ~/.config/nvim/lv-settings.lua'}
}

vim.g.dashboard_custom_footer = {''}
