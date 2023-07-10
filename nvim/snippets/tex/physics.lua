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

-- Math context detection 
local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

-- Return snippet tables
return
	{
		-- CONSTANTE DE PLANCK
		s({trig = '([^%a])hb', regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\hbar<>",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual)
				}
			),
			{condition = tex.in_mathzone}
		),
		--
		-- KET
		s({trig = '([^%a])ket', regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>|{<>}\\rangle",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual)
				}
			),
			{condition = tex.in_mathzone}
		),
		--
		-- BRA
		s({trig = '([^%a])bra', regTrig = true, wordTrig = false, snippetType="autosnippet"},
			fmta(
				"<>\\langle{<>}|",
				{
					f( function(_, snip) return snip.captures[1] end ),
					d(1, get_visual)
				}
			),
			{condition = tex.in_mathzone}
		),
		-- End Refactoring --
	}



