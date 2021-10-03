WORKSPACE_PATH = "/home/" .. os.getenv "USER" .. "/.workspace/"
JAVA_LS_EXECUTABLE = os.getenv "HOME" .. "/.local/bin/jdtls"

require("jdtls").start_or_attach {
  on_attach = require("lsp").common_on_attach,
  cmd = { JAVA_LS_EXECUTABLE, WORKSPACE_PATH .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
  settings = {
    java = {
      format = {
        enabled = false,
      },
      project = {
        referencedLibraries = { "lib/**/*.jar" },
      },
    },
  },
}
vim.bo.shiftwidth = 4
