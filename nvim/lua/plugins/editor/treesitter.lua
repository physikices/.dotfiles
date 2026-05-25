return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "lua",
      "javascript",
      "fortran",
      "markdown",
      "markdown_inline",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "javascript",
        "fortran",
        "markdown",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "latex", "tex" },
      callback = function()
        vim.treesitter.stop()
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "javascript",
        "fortran",
        "markdown",
      },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
