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
local c = ls.choice_node


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

local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  ls.add_snippets("tex", {
    -- DIRAC NOTATION
    -- vector ket
    s(
      {
        trig = "([^%a])kV",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\ket{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- vector bra
    s(
      {
        trig = "([^%a])bV",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\bra{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- inner product
    s(
      {
        trig = "([^%a])iP",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\ip{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- outer product
    s(
      {
        trig = "([^%a])oP",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\op{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- matrix element
    s(
      {
        trig = "([^%a])mE",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\mel{<>}{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
          i(3),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- expactation value
    s(
      {
        trig = "([^%a])eV",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\ev{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- hat notation
    s(
      {
        trig = "([^%a])hH",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\hat{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),

    -- bar notation
    s(
      {
        trig = "([^%a])bB",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\overbar{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- expactation value
    s(
      {
        trig = "([^%a])cmm",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\comm{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- slashed notation
    s(
      {
        trig = "([^%a])sS",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\slashed{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- dagger notation
    s(
      {
        trig = "([%w%)%]%}])dD",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{\\dagger}<>",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
  })
}
