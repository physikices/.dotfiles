return {
  "nvimdev/lspsaga.nvim",

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
  },

  event = "LspAttach",
  config = function()
    local icons = require("user-icons")
    require("lspsaga").setup({
      ui = {
        sign = true,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        devicon = true,
        title = true,
        expand = icons.kind.Expand,
        collapse = icons.kind.Collapse,
        code_action = icons.ui.Lightbulb,
        actionfix = icons.kind.ActionFixa,
        lines = { '┗', '┣', '┃', '━', '┏' },
        imp_sign = icons.kind.ImpSign,
      },
    })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', {})
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_next<CR>', {})
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {})
    vim.keymap.set({'n','t'}, '<leader>tt', '<cmd>Lspsaga term_toggle<CR>', {})
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {})
    vim.keymap.set('n', '<leader>gd', '<cmd>Lspsaga peek_definition<CR>', {})
  end,
}
