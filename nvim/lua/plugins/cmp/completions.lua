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
    local luasnip = require("luasnip")

    local icons = require("user-icons")
    local types = require("cmp.types")

    require("luasnip.loaders.from_vscode").lazy_load()

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

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
        ["<C-k>"] = cmp.mapping(
          cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
          { "i", "c" }
        ),
        ["<C-j>"] = cmp.mapping(
          cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
          { "i", "c" }
        ),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },

        ["<Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            require("neotab").tabout()
          else
            require("neotab").tabout()
          end
        end, {
            "i",
            "s",
          }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
            "i",
            "s",
          }),


      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },{
        { name = "path" },
      },{
        { name = "buffer" },
          -- { name = "vimtex", },
          -- { name = "lspconfig" }, -- nao funciona
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s %s", icons.kind[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            -- vimtex = "",
            nvim_lsp = "[lsp]",
            luasnip = "[snp]",
            --treesitter = "[tre]",
            --nvim_lua = "[nvl]",
            path = "[pth]",
            buffer = "[buf]",
            -- spell = "[spl]",
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
