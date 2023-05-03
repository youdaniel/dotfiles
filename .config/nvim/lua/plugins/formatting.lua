local nls = require("null-ls")
local formatters = {
  black = nls.builtins.formatting.black,
  isort = nls.builtins.formatting.isort,
  prettierd = nls.builtins.formatting.prettierd,
}

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      for formatter, _ in pairs(formatters) do
        table.insert(opts.ensure_installed, formatter)
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      for _, source in pairs(formatters) do
        table.insert(opts.sources, source)
      end
    end,
  },
}
