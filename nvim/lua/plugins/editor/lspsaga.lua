return {
  "nvimdev/lspsaga.nvim",

  event = "LspAttach",
  config = function()
    require("lspsaga").setup({})
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', {})
    vim.keymap.set('n', '[e', '<cmd>Lspsaga diagnostic_jump_next<CR>', {})
    vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', {})
    vim.keymap.set({'n','t'}, '<leader>tt', '<cmd>Lspsaga term_toggle<CR>', {})
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', {})
    vim.keymap.set('n', '<leader>gd', '<cmd>Lspsaga peek_definition<CR>', {})
  end,
}
