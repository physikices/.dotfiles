local present, cmp = pcall(require, "cmp")
if not present then return end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
cmp.setup {
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
	-- experimental = {
	-- 	ghost_text = true,
	-- },
	snippet = {
		expand = function(args) require("luasnip").lsp_expand(args.body) end,
	},
	sources = cmp.config.sources({
		{ name = "luasnip",
			entry_filter = function(entry)
				return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
			end
		},
		{ name = "nvim_lsp",
			entry_filter = function (entry)
				return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
			end
		},
		},{
			{ name = "buffer" },
		},{
			{ name = "path" },
	}),
	--{ name = "treesitter" },
	--{ name = "nvim_lua" },
	--{ name = "spell" },
	--{ name = "emoji" },
	--{ name = "calc" },
	--{ name = "cmdline" },
	formatting = {
		format = function(entry, vim_item)
			local icons = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "ﰠ",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "塞",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = " ",
				symbol_map = { Codeium = "", }
			}
			-- vim_item.kind = require "lspkind".symbol_map[vim_item.kind]
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
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
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-n>"] = cmp.mapping(function(fallback)
			if require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		["<Tab>"] = cmp.mapping(function(fallback)
			-- if cmp.visible() then
			-- 	cmp.select_next_item()
			-- elseif require("luasnip").expand_or_jumpable() then
			-- 	require("luasnip").expand_or_jump()
			-- elseif has_words_before() then
			-- 	cmp.complete()
			-- else
			if cmp.visible() and cmp.get_active_entry() then
				-- completion if a cmp item is selected
				cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
			elseif vim.fn.exists('b:_codeium_completions') ~= 0 then
				-- accept codeium completion if visible
				vim.fn['codeium#Accept']()
				fallback()
			elseif cmp.visible() then
				-- select first item if visible
				cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
			elseif has_words_before() then
				-- show autocomplete
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
}
