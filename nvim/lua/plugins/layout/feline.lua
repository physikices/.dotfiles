return {
  -- "feline-nvim/feline.nvim",
  dir = "~/.config/nvim/forks/feline.nvim",
  name = "feline.nvim",

  config = function ()
    local ctp_feline = require "catppuccin.groups.integrations.feline"
    require('feline').setup({
      components = ctp_feline,
      options = {
        theme = 'catppuccin',
      }
    })
  end
}

