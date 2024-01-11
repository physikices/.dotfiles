local m = vim.keymap.set
local s = { silent = true }


-- Split window
m('n', 'ss', ':split<Return><C-w>w')
m('n', 'sv', ':vsplit<Return><C-w>w')

-- Move window
m('', 'sh', '<C-w>h')
m('', 'sk', '<C-w>k')
m('', 'sj', '<C-w>j')
m('', 'sl', '<C-w>l')

-- navigate within insert mode
-- m("i", "<C-h>", "<Left>") -- "   move left"
-- m("i", "<C-l>", "<Right>") -- " move right"
-- m("i", "<C-j>", "<Down>") -- " move down"
-- m("i", "<C-k>", "<Up>") -- " move up" },

-- bufferline
m("n", "<S-e>", "<cmd>BufferLinePick<CR>", s)

-- highlights
m("n","<leader>h", "<cmd>nohl<CR>", s)

-- toggle boolean
m('n','<leader>ta','<cmd>ToggleAlternate<CR>', s)


-- * keybindings noremape=true silent=true * --
--
-- save and quite
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', {})
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', {})


-- Move Lines
vim.keymap.set('v', '<leader>j', ":m '>+1<cr>gv=gv", {})
vim.keymap.set('v', '<leader>k', ":m '<-2<cr>gv=gv", {})
vim.keymap.set('n', '<leader>j', ':m.+1<CR>==', {})
vim.keymap.set('n', '<leader>k', ':m.-2<CR>==', {})

-- indent
vim.keymap.set('n', '<leader>i', 'gg=G', {})

-- close current buffer
vim.keymap.set("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>", {})

-- highlights
vim.keymap.set("n","<leader>h", "<cmd>nohl<CR>", {})

-- toggle boolean
vim.keymap.set('n','<leader>ta','<cmd>ToggleAlternate<CR>', {})

-- codeium 
vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<C-d>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
