local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

-- Determine OS
local home = vim.env.HOME
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason")
local launcher_path = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
if #launcher_path == 0 then
  launcher_path = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
end
local CONFIG = "linux"
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
else
  vim.notify("Unsupported system", vim.log.levels.ERROR)
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_path,
    "-configuration",
    mason_path .. "/packages/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },

  on_attach = require("lvim.lsp").common_on_attach,
  on_init = require("lvim.lsp").common_on_init,
  on_exit = require("lvim.lsp").common_on_exit,
  capabilities = require("lvim.lsp").common_capabilities(),
  root_dir = root_dir,
  settings = {
    java = {
      referencesCodeLens = {
        enabled = false,
      },
      format = {
        enabled = true,
        settings = {
          profile = "GoogleStyle",
          url = home .. "/.config/lvim/.java-google-formatter.xml",
        },
      },
    },
  },
}

jdtls.start_or_attach(config)
