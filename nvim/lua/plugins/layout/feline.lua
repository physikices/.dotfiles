return {
  "feline-nvim/feline.nvim",
  config = function ()
    local ctp_feline = require "catppuccin.groups.integrations.feline"
    require('feline').setup({
      components = ctp_feline.get(),
      options = {
        theme = 'catppuccin',
      }
    })
  end
}

