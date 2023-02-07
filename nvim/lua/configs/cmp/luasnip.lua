local ls = require "luasnip"
local types = require "luasnip.util.types"

local ps = require("utils").path_separator

ls.config.set_config {
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	ext_base_prio = 300,
	ext_prio_increase = 1,
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	ft_func = function() return vim.split(vim.bo.filetype, ".", true) end,
}


require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})

-- require("luasnip.loaders.from_lua").lazy_load { paths = "./snippets/luasnip" }
-- require("luasnip.loaders.from_snipmate").lazy_load { paths = "./snippets/snipmate" }
require("luasnip.loaders.from_vscode").lazy_load() -- use it with: rafamadriz/friendly-snippets. load snippets in the vscode, from friendly-snippets. If the language has too many then it might be a tad slow
require("luasnip.loaders.from_lua").lazy_load { paths = "./snippets/luasnip" }require("luasnip.loaders.from_vscode").lazy_load { paths = vim.fn.stdpath "config" .. ps .. "snippets" } -- load some custom snippets
