return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      local icons = require("user-icons")

      local default_diagnostic_config = {
        signs = {
          active = true,
          values = {
            { name = "DiagnosticSignError", text = icons.diagnostics.Error },
            { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
            { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
            { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
          },
        },
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
      };

      vim.diagnostic.config(default_diagnostic_config)

      for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
      require("lspconfig.ui.windows").default_options.border = "rounded"

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
