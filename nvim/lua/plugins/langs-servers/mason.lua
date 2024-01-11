return {
  {
    "williamboman/mason.nvim",

    build = ":MasonUpdate",
    config = function ()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {
          'lua_ls',
          'fortls',
          'html',
          'cssls',
          'tsserver'
        }
      })
    end
  },
}
