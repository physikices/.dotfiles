return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.fortls.setup({
        capabilities = capabilities,
        cmd = {
          'fortls',
          '--notify_init',
          '--hover_signature',
          '--hover_language=fortran',
          '--use_signature_help',
          '--incremental_sync',
          '--sort_keywords',
          '--source_dirs',
          '--autocomplete_no_snippets',
          '--lowercase_intrinsics'
        },
        filetypes = { 'fortran' },
        docs = {
          vscode = "hansec.fortran-ls",
          default_config = {
            root_dir = [[root_pattern(".fortls")]]
          }
        },
        settings = {
          nthreads = 1,
        },
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
    end
  }
}
