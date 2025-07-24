local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '$HOME/.venv/bin/python3'

-- Desabilita temporariamente PYTHON_ARGCOMPLETE_OK para evitar o erro
vim.env._ARGCOMPLETE = 0

require("user-options")
require("user-mappings")
require("user-icons")
require("user-autocmds")

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.cmp" },
  { import = "plugins.editor" },
  { import = "plugins.langs-servers" },
  { import = "plugins.layout" },

  { import = "snippets" },
  install = {
    colorscheme = { "catpuccin", "default" },
  },
  ui = {
    border = "rounded",
  },
  checker = { enabled = true },
})

