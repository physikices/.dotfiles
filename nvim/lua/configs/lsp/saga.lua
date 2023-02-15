local present, saga = pcall(require, "lspsaga")
if not present then return end

saga.setup({
	ui = {
		winblend = 10,
		border = 'rounded',
		colors = {
			normal_bg = '#002b36'
		}
	}
})

local diagnostic = require("lspsaga.diagnostic")
local m = vim.keymap.set
local opts = {noremap = true, silent = true}
m('n', '<C-j>','<Cmd>Lspsaga diagnostic_jump_next<CR>', opts )
m('n', 'gl', '<Cmd>Lspsaga show_diagnostic<CR>', opts)
m('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
m('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
m('i', '<C-k>', '<Cmd>lua vim.lsp.buf.sgnature_help()<CR>', opts)
m('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
m('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- code action
local codeaction = require("lspsaga.codeaction")
m("n", "<leader>ca", function() codeaction:code_action() end, { silent = true })
m("v", "<leader>ca", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_code_action()
end, { silent = true })

