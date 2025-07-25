local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end


-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- vimtex conceal
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
  pattern = { "bib", "tex" },
  callback = function()
    vim.wo.conceallevel = 0 -- put 2 to activate it
  end,
})

-- remove lsp.log on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup("clean_lsp_log"),
  callback = function()
    local log = vim.fn.stdpath("state") .. "/lsp.log"
    if vim.fn.filereadable(log) == 1 then
      vim.notify("Removing LSP log: " .. log)
      os.remove(log)
    end
  end,
})
