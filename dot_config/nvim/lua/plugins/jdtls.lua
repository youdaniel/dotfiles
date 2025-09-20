local function patch_gradle_loading_times()
  local root_markers = { "build.gradle", "pom.xml" }
  local root_dir = require("jdtls.setup").find_root(root_markers)

  -- For Gradle only lets remove the .settings folder
  if root_dir ~= nil then
    local f = io.open(root_dir .. "/build.gradle", "r")
    if f ~= nil then
      io.close(f)
      vim.api.nvim_exec2([[ let test#java#runner = 'gradletest' ]], { output = true })
      os.execute("rm -rf " .. root_dir .. "/.settings")
    end
  end
end

return {
  "mfussenegger/nvim-jdtls",
  opts = {
    jdtls = {
      before_init = patch_gradle_loading_times,
    },
  },
}
