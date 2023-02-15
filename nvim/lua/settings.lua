local g = vim.g
local o = vim.opt
local cmd = vim.cmd

o.number = true
o.relativenumber = true
o.numberwidth = 2

o.laststatus = 3 -- global statusline
o.title = true
o.cul = true -- cursor line
o.showmode = false
o.clipboard = "unnamedplus"

-- Indentline
o.expandtab = false
o.shiftwidth = 2
o.smartindent = true
o.autoindent = true

o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.tabstop = 2
o.termguicolors = true
o.timeoutlen = 400
o.undofile = true
o.scrolloff = 10
o.sidescrolloff = 10
o.syntax = 'true'
-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

o.pumheight = 15
o.linebreak = true

o.encoding = "utf-8"
vim.scriptencoding = "utf-8"
o.fileencoding = "utf-8"
g.tex_flavor = "latex"

g.mapleader = ' '
g.maplocalleader = ' '
