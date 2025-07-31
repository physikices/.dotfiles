return {
  "L3MON4D3/LuaSnip",

  -- tag = "v2.4.0",
  version = "2.*",
  ft = { "tex", "bib" },
  build = "make install_jsregexp",
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
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { "choiceNode  <C-l>/<C-s>", "DiagnosticHint" } },
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    {
      "<Tab>",
      function()
        return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      end,
      expr = true, silent = true, mode = "i",
    },

    { "<Tab>", function() require("luasnip").jump(1) end, mode = "s" },
    { "<s-Tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    { "<C-l>", function() require("luasnip").change_choice(1) end, mode = { "i", "s" } },
    { "<C-s>", function() require("luasnip").change_choice(-1) end, mode = { "i", "s" } },
  },
}
