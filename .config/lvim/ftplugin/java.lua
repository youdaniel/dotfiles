require("jdtls").start_or_attach {
  on_attach = require("lsp").common_on_attach,
  cmd = { "jdtls", "/home/daniel/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
}

vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
