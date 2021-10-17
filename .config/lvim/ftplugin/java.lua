local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

WORKSPACE_PATH = os.getenv "HOME" .. "/.workspace/"
JAVA_LS_EXECUTABLE = os.getenv "HOME" .. "/.local/bin/jdtls"

jdtls.start_or_attach {
  on_attach = require("lvim.lsp").common_on_attach,
  cmd = { JAVA_LS_EXECUTABLE, WORKSPACE_PATH .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
  settings = {
    java = {
      format = {
        enabled = false,
      },
      referencesCodeLens = {
        enabled = false,
      },
      project = {
        referencedLibraries = { "lib/**/*.jar" },
      },
    },
  },
}
vim.bo.shiftwidth = 4
