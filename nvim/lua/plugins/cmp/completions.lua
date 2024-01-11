return {

  "hrsh7th/nvim-cmp",

  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local icons = require("user-icons")
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
        },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "lspconfig" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            luasnip = "[snp]",
            nvim_lsp = "[lsp]",
            buffer = "[buf]",
            --treesitter = "[tre]",
            --nvim_lua = "[nvl]",
            path = "[pth]",
            --spell = "[spl]",
            --emoji = "[emj]",
            --calc = "[clc]",
            --cmdline = "[cmd]",
          })[entry.source.name]
          if vim_item.source == "luasnip" or vim_item.source == "nvim_lsp" then
            vim_item.dup = 0
          end
          return vim_item
        end,
      }
    })
  end
}

