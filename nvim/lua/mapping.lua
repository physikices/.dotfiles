local m = vim.keymap.set
local ns = { noremap = true, silent = true }
local s = { silent = true }

-- Delete a word backwards
m('n', 'dw', 'vb"_d')
-- New tab
m('n', 'te', ':tabedit')
-- Split window
m('n', 'ss', ':split<Return><C-w>w')
m('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
m('n', '<Space>', '<C-w>w')
m('', 'sh', '<C-w>h')
m('', 'sk', '<C-w>k')
m('', 'sj', '<C-w>j')
m('', 'sl', '<C-w>l')
-- Move Lines
m('v', '<leader>j', ":m '>+1<cr>gv=gv", ns)
m('v', '<leader>k', ":m '<-2<cr>gv=gv", ns)
m('n', '<leader>j', ':m.+1<CR>==', ns)
m('n', '<leader>k', ':m.-2<CR>==', ns)
-- m('i', '<leader>j', '<esc><cmd>m .+1<cr>==gi', ns)
-- m('i', '<leader>k', '<esc><cmd>m .-2<cr>==gi', ns)
-- navigate within insert mode
m("i", "<C-h>", "<Left>") -- "   move left"
m("i", "<C-l>", "<Right>") -- " move right"
m("i", "<C-j>", "<Down>") -- " move down"
m("i", "<C-k>", "<Up>") -- " move up" },

m('n', '<leader>w', '<cmd>w<cr>', ns)
m('n', '<leader>q', '<cmd>q<cr>', ns)

-- indent
m('n', '<leader>i', 'gg=G', ns)

-- bufferline
m("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>") -- close buffer
m("n", "<leader>n", "<cmd> enew <CR>") -- new buffer
m("n", "<leader>g", "<cmd> BufferLinePick <CR>") -- pick a buffer to go to
m("n", "<PageUp>", "<cmd>BufferLineCycleNext<CR>", s)
m("n", "<PageDown>", "<cmd>BufferLineCyclePrev<CR>", s)
m("i", "<PageUp>", "<cmd>BufferLineCycleNext<CR>", s)
m("i", "<PageDown>", "<cmd>BufferLineCyclePrev<CR>", s)
m("n", "<C-PageUp>", "<cmd>BufferLineMoveNext<CR>", s)
m("n", "<C-PageDown>", "<cmd>BufferLineMovePrev<CR>", s)
m("n", "<S-e>", "<cmd>BufferLinePick<CR>", s)
for i = 1, 9 do
	m("n", "<leader>" .. i, function() require("bufferline").go_to_buffer(i) end, s)
end

-- nvimtree
-- m("n", "<C-d>", "<cmd> NvimTreeToggle <CR>", ns)
m("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", ns)

-- lsp 
vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'Acciones LSP',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = {buffer = true}
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		-- Muestra información sobre símbolo debajo del cursor
		bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
		-- Saltar a definición
		bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
		-- Saltar a declaración
		bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
		-- Mostrar implementaciones
		bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
		-- Saltar a definición de tipo
		bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
		-- Listar referencias
		bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
		-- Mostrar argumentos de función
		bufmap('n', '<C-n>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
		-- Renombrar símbolo
		bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
		-- Listar "code actions" disponibles en la posición del cursor
		bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
		bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
		-- Mostrar diagnósticos de la línea actual
		bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
		-- Saltar al diagnóstico anterior
		bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		-- Saltar al siguiente diagnóstico
		bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		-- Telescop/LSP referencias
		bufmap('n', '<leader>r', '<cmd>Telescope lsp_references<CR>')
	end
})
-- truezen
m("n", "<leader>zz", ":TZAtaraxis<CR>", s)
m("n", "<leader>zm", ":TZMinimalist<CR>",s)
m("n", "<leader>zf", ":TZFocus<CR>",s)
m("n", "<leader>zn", ":TZNarrow<CR>",s)
m("v", "<leader>zn", ":'<,'>TZNarrow<CR>",s)

-- highlights
m("n","<leader>h", "<cmd>nohl<CR>", s)

-- toggle boolean
m('n','<leader>ta','<cmd>ToggleAlternate<CR>', s)

-- telescope
m("n", "<leader>vv", "<cmd> Telescope<CR>") -- "  find files"
m("n", "<leader>vf", "<cmd> Telescope find_files <CR>") -- "  find files"
m("n", "<leader>va", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>") --"  find all"
m("n", "<leader>vl", "<cmd> Telescope live_grep <CR>") --"	live grep"
m("n", "<leader>vp", "<cmd> Telescope pickers <CR>") --"	pickers"
m("n", "<leader>vr", "<cmd> Telescope registers <CR>") --"	pickers"
m("n", "<leader>vb", "<cmd> Telescope buffers <CR>") --"  find buffers"
m("n", "<leader>vh", "<cmd> Telescope help_tags <CR>") --"  help page"
m("n", "<leader>vo", "<cmd> Telescope oldfiles <CR>") --"	find oldfiles"
m("n", "<leader>vc", "<cmd> Telescope git_commits <CR>") --"	git commits"
m("n", "<leader>vs", "<cmd> Telescope git_status <CR>") --"  git status"
m("n", "<leader>vt", "<cmd> Telescope terms <CR>") --"	pick hidden term"
m("n", "<leader>mf", "<cmd> Telescope media_files <CR>") --"	pick hidden term"

-- packer
m("n", "<leader>p", function()
	local present, packer = pcall(require, "packer")
	if present then
		require "plugins"
		packer.sync()
	else
		vim.notify("Error: Packer is missing! Installing it...", vim.log.levels.WARN)
	end
end, s)

m("n", "<leader><CR>", "<cmd>LuaSnipEdit<cr>", ns)
