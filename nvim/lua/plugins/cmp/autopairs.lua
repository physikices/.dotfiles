return {
  "windwp/nvim-autopairs",

  config = function()
    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    require("nvim-autopairs").setup({
      disable_filetype = { "tex" },
    })
  end,
}
