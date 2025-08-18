return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local config = require('nvim-treesitter.configs')
    config.setup({
      ensure_installed = {
        "lua",
        "javascript",
        "fortran",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
    })

    -- sobrescreve highlights só depois do setup
    vim.api.nvim_set_hl(0, "@keyword.module",   { fg = "#ff5555", bold = true })
    vim.api.nvim_set_hl(0, "@keyword.contains", { fg = "#50fa7b", italic = true })
    vim.api.nvim_set_hl(0, "@keyword.end",      { fg = "#bd93f9", underline = true })
  end
}

