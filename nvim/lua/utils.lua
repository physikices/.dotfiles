local M = {}

M.path_separator = (vim.fn.has "win32" == 1 or vim.fn.has "win32unix" == 1 and "\\" or "/")

return M

