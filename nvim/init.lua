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

require("user-options")
require("user-mappings")
require("user-icons")

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

