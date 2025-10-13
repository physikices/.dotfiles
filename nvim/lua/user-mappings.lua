local m = vim.keymap.set
local s = { silent = true }


-- Split window
m('n', 'ss', ':split<Return><C-w>w')
m('n', 'sv', ':vsplit<Return><C-w>w')

-- navigate window
m('', 'sh', '<C-w>h')
m('', 'sk', '<C-w>k')
m('', 'sj', '<C-w>j')
m('', 'sl', '<C-w>l')

-- navigate tab
m('', 'tn', ':tabnext<Return>')
m('', 'tp', ':tabprevious<Return>')
m('', 'tt', ':tabnew<Return>')
m('', 'tq', ':tabclose<Return>')

-- navigate within insert mode
-- m("i", "<C-h>", "<Left>") -- "   move left"
-- m("i", "<C-l>", "<Right>") -- " move right"
-- m("i", "<C-j>", "<Down>") -- " move down"
-- m("i", "<C-k>", "<Up>") -- " move up" },

-- bufferline
m("n", "<S-e>", "<cmd>BufferLinePick<CR>", s)

-- highlights Tree-sitter
m("n", "<leader>th", "<cmd>TSBufToggle highlight<CR>", s)

-- toggle boolean
m('n','<leader>ta','<cmd>ToggleAlternate<CR>', s)


-- * keybindings noremape=true silent=true * --
--
-- save and quite
m('n', '<leader>w', '<cmd>w<CR>', {})
m('n', '<leader>q', '<cmd>q<CR>', {})


-- Move Lines
m('v', '<leader>j', ":m '>+1<cr>gv=gv", {})
m('v', '<leader>k', ":m '<-2<cr>gv=gv", {})
m('n', '<leader>j', ':m.+1<CR>==', {})
m('n', '<leader>k', ':m.-2<CR>==', {})

-- indent
m('n', '<leader>i', 'gg=G', {})

-- close current buffer
m("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>", {})

-- highlights
m("n","<leader>h", "<cmd>nohl<CR>", {})

-- toggle boolean
m('n','<leader>ta','<cmd>ToggleAlternate<CR>', {})
-- codeium 
m('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
m('i', '<C-s>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
m('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
m('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
