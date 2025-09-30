return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- carrega antes de outros temas/plugins
    opts = {
      flavour = "mocha", -- opcional: mocha, macchiato, frappe, latte
      integrations = {
        bufferline = true,
        feline = true,
        -- adicione outras integrações que use
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

