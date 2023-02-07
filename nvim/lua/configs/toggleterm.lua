local present, toggleterm = pcall(require, "toggleterm")
if not present then return end

toggleterm.setup({
  direction = 'float',
  open_mapping = [[<C-\>]],
})
