-- local helpers = require('snippets.tex.boilerplate')
-- local get_visual = helpers.get_visual

local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local get_visual = function(args, parent)
	if (#parent.snippet.env.SELECT_RAW > 0) then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else  -- If SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local snippets, autosnippets = {}, {}


-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
	{
		-- LEFT/RIGHT PARENTHESES
		s({trig = "([^%a])l%(", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\left(<>\\right)",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- LEFT/RIGHT SQUARE BRACES
		s({trig = "([^%a])l%[", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\left[<>\\right",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- LEFT/RIGHT CURLY BRACES
		s({trig = "([^%a])l%{", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\left\\{<>\\right\\}",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- BIG PARENTHESES
		s({trig = "([^%a])b%(", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\big(<>\\big)",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- BIG SQUARE BRACES
		s({trig = "([^%a])b%[", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\big[<>\\big]",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- BIG CURLY BRACES
		s({trig = "([^%a])b%{", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\big\\{<>\\big\\}",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- MEDIA
		s({trig = "([^%a])l%<", regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\langle <> \\rangle",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- ESCAPED CURLY BRACES
		s({trig = "([^%a])\\%{", regTrig = true, wordTrig = false, snippetType="autosnippet", priority=2000},
			fmta(
				"<>\\{<>\\}",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual),
				}
			)
		),
		-- LATEX QUOTATION MARK
		s({trig = "``", snippetType="autosnippet"},
			fmta(
				"``<>''",
				{
					d(1, get_visual),
				}
			)
		),
		-- End Refactoring --
}



