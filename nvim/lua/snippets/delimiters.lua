-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local ms = ls.multi_snippet

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

-- Return snippet tables
return {
  ls.add_snippets("tex", {
    -- LEFT/RIGHT PARENTHESES
    s(
      {
        trig = "([^%a])l%(",
        regTrig = true,
        wordTrig = false,
        snippetType = "autosnippet",
      },
      fmta(
        [[
          <>\left(<>\right)
        ]],
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      )
    ),
    -- LEFT/RIGHT SQUARE BRACES
    s(
      {
        trig = "([^%a])l%[",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\left[<>\\right]",
        {
          f( function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      )
    ),
    -- LEFT/RIGHT CURLY BRACES
    s(
      {
        trig = "([^%a])l%{",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\left\\{<>\\right\\}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      )
    ),
    -- BIG PARENTHESES
    s(
      {
        trig = "([^%a])b%(",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\big(<>\\big)",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      )
    ),
    -- BIG SQUARE BRACES
    s(
      {
        trig = "([^%a])b%[",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\big[<>\\big]",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      )
    ),
    -- BIG CURLY BRACES
    s(
      {
        trig = "([^%a])b%{",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\big\\{<>\\big\\}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end ),
          d(1, get_visual),
        }
      )
    ),
    -- ESCAPED CURLY BRACES
    s(
      {trig = "([^%a])\\%{",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet",
        priority=2000
      },
      fmta(
        "<>\\{<>\\}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end ),
          d(1, get_visual),
        }
      )
    ),
    -- LATEX QUOTATION MARK
    s(
      {
        trig = "``",
        snippetType="autosnippet"
      },
      fmta(
        "``<>''",
        {
          d(1, get_visual),
        }
      )
    ),
  }),
}
