return {
  "nvim-treesitter/nvim-treesitter",
  -- garante que roda depois do setup do TS
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "javascript",
        "fortran",
        "markdown",
        "markdown_inline"
      },
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      },
    })

    local function apply_fortran_styles()
      -- Keywords que você já tinha
      -- vim.api.nvim_set_hl(0, "@keyword.module.fortran",   { bold = true })
      vim.api.nvim_set_hl(0, "@keyword.contains.fortran", { italic = true })

      -- Keywords customizadas com "hooks" em highlights.cm
      vim.api.nvim_set_hl(0, "@keyword.declaration.fortran", { fg = "#B4BEFE", bold = true })
      vim.api.nvim_set_hl(0, "@keyword.control.fortran",     { fg = "#CBA6F7", bold = true })
      vim.api.nvim_set_hl(0, "@keyword.specials.fortran",    { fg = "#89b4fa", bold = true })

      -- destaque das chamadas de função/subroutine
      vim.api.nvim_set_hl(0, '@fortran.func.call', { fg = "#f2cdcd", bold = true })
      vim.api.nvim_set_hl(0, '@function.fortran',  { fg = "#f2cdcd", bold = false })

      -- Tipos intrínsecos
      vim.api.nvim_set_hl(0, "@type.real.fortran",    { fg = "#89dceb", bold = true })
      vim.api.nvim_set_hl(0, "@type.builtin.fortran", { fg = "#94e2d5", bold = true })
      vim.api.nvim_set_hl(0, "@type.integer.fortran", { fg = "#74c7ec", bold = true })
      vim.api.nvim_set_hl(0, "@type.logical.fortran", { fg = "#89b4fa", bold = true })
      vim.api.nvim_set_hl(0, "@type.complex.fortran", { fg = "#b4befe", bold = true })

      -- Type-bound members
      vim.api.nvim_set_hl(0, "@variable.member.bound.fortran", { fg = "#89b4fa", italic = true })
    end

    apply_fortran_styles()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_fortran_styles })

  end,
}

