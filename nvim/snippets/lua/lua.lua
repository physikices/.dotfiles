local ls = require("luasnip")
local s = ls.s -- snippet
local i = ls.i -- insert
local t = ls.t -- text

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"



-- Place your snippets here
local myFirstSnippet = s("myFirstSnippet", {
	t("Hi! Rodrigo my first snippet Funcionando"),
	i(1, "placeholder_text"),
})
table.insert(snippets, myFirstSnippet)
--
local mySecondSnippet = s(
	"mySecondSnipet",
	fmt(
		[[
		local {} = function({})
		{} {{Este texto está entre parenteses}}
		end
		]],
		{
			i(1, "myVar"),
			c(2, {t(""), t("myArg")}),
			i(3, "-- TODO: faça algo"),
		}
	)
)
table.insert(snippets, mySecondSnippet)
--

-- End Refactoring --
return snippets, autosnippets


