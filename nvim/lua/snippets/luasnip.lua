return {
  "L3MON4D3/LuaSnip",

  ft = { "tex", "bib" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",

    config = function()
      ---@diagnostic disable-next-line: assign-type-mismatch
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/luasnippets/" })
    end,
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
  },
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      end,
      expr = true, silent = true, mode = "i",
    },
    { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    { "<C-n>", function() require("luasnip").change_choice(1) end, mode = { "i", "s" } },
    { "<C-p>", function() require("luasnip").change_choice(-1) end, mode = { "i", "s" } },
  },
}
