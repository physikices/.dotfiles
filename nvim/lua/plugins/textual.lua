return {
  {
    "mg979/vim-visual-multi",
  },{
    "tpope/vim-surround",
  },{
    "gcmt/wildfire.vim",
  },{
    "rmagatti/alternate-toggler",

    event = { "BufReadPost" }, -- lazy load after reading a buffer
    config = function()
      require("alternate-toggler").setup {
        alternates = {
          ["=="] = "!="
        }
      }
    end,
  }
}
