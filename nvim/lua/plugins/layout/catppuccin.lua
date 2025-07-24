return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        notify = true, -- ativa a integração com nvim-notify
        vim.cmd.colorscheme "catppuccin",
        -- você pode ativar outras integrações aqui também, como:
        treesitter = true,
        lsp_trouble = true,
        gitsigns = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

