return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local lspconfig = require('lspconfig')
      local lspconfig = vim.lsp.config
      local icons = require("user-icons")

      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = false,
        underline = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
          },
        },
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      require("lspconfig.ui.windows").default_options.border = "rounded"

      lspconfig('lua_ls',{
        capabilities = capabilities
      })
      lspconfig('fortls',{
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
      -- lspconfig.ts_ls.setup({
      --   capabilities = capabilities
      -- })
      -- lspconfig.html.setup({
      --   capabilities = capabilities
      -- })
      -- lspconfig.cssls.setup({
      --   capabilities = capabilities
      -- })
    end
  }
}
