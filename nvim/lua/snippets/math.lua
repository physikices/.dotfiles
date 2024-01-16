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
    -- SUPERSCRIPT
    s(
      {
        trig = "([%w%)%]%}])'",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      {condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT
    s(
      {
        trig = "([%w%)%]%}]);",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>_{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT AND SUPERSCRIPT
    s(
      {
        trig = "([%w%)%]%}])__",
        wordTrig=false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- TEXT SUBSCRIPT
    s(
      {
        trig = 'sd',
        snippetType="autosnippet",
        wordTrig=false
      },
      fmta("_{\\mathrm{<>}}",
        {
          d(1, get_visual)
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SUPERSCRIPT SHORTCUT
    -- Places the first alphanumeric character after the trigger into a superscript.
    s(
      {
        trig = '([%w%)%]%}])"([%w])',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          f(function(_, snip)
            return snip.captures[2]
          end),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SUBSCRIPT SHORTCUT
    -- Places the first alphanumeric character after the trigger into a subscript.
    s(
      {
        trig = '([%w%)%]%}]):([%w])',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          f(function(_, snip)
            return snip.captures[2]
          end),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- EULER'S NUMBER SUPERSCRIPT SHORTCUT
    s(
      {
        trig = '([^%a])ee',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>e^{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          d(1, get_visual)
        }
      ),
      { condition = tex.in_mathzoneu }
    ),
    -- ZERO SUBSCRIPT SHORTCUT
    s(
      {
        trig = '([%a%)%]%}])00',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>_{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          t("0")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- MINUS ONE SUPERSCRIPT SHORTCUT
    s(
      {
        trig = '([%a%)%]%}])11',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          t("-1")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- J SUBSCRIPT SHORTCUT (since jk triggers snippet jump forward)
    s(
      {
        trig = '([%a%)%]%}])JJ',
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          t("j")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- PLUS SUPERSCRIPT SHORTCUT
    s(
      {
        trig = '([%a%)%]%}])%+%+',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          t("+")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- COMPLEMENT SUPERSCRIPT
    s(
      {
        trig = '([%a%)%]%}])CC',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          t("\\complement")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
    s(
      {
        trig = '([%a%)%]%}])%*%*',
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          t("*")
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- VECTOR, i.e. \vec
    s(
      {
        trig = "([^%a])vv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\vec{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- DEFAULT UNIT VECTOR WITH SUBSCRIPT, i.e. \unitvector_{}
    s(
      {
        trig = "([^%a])ue",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\vu{e}_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- UNIT VECTOR WITH HAT, i.e. \uvec{}
    s(
      {
        trig = "([^%a])uv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\vu*{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- VECTOR BOLD
    s(
      {
        trig = "([^%a])vb",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\vb{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- FRACTION
    s(
      {
        trig = "([^%a])ff",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\frac{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
          i(2),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- ABSOLUTE VALUE
    s(
      {
        trig = "([^%a])aa",
        regTrig = true,
        wordTrig = false,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\abs{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end ),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SQUARE ROOT
    s(
      {
        trig = "([^%\\])sq",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\sqrt{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- BINOMIAL SYMBOL
    s(
      {
        trig = "([^%\\])bnn",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\binom{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- LOGARITHM WITH BASE SUBSCRIPT
    s(
      {
        trig = "([^%a%\\])ll",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\log_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
        }
      ),
      {condition = tex.in_mathzone}
    ),
    -- DERIVATIVE with denominator only
    s(
      {
        trig = "([^%a])dV",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\dv{<>}",
        {
          f(function(_, snip) return
            snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator and denominator
    s(
      {
        trig = "([^%a])dvv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\dv{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2)
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- DERIVATIVE with numerator, denominator, and higher-order argument
    s(
      {
        trig = "([^%a])ddv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\dv[<>]{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
          i(3),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with denominator only
    s(
      {
        trig = "([^%a])pV",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\pdv{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator and denominator
    s(
      {
        trig = "([^%a])pvv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\pdv{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2)
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
    s(
      {
        trig = "([^%a])ppv",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\pdv[<>]{<>}{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
          i(3),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SUM with lower limit
    s(
      {
        trig = "([^%a])sM",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\sum_{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- SUM with upper and lower limit
    s(
      {
        trig = "([^%a])smm",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\sum_{<>}^{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- INTEGRAL with upper and lower limit
    s(
      {
        trig = "([^%a])intt",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\int\\limits_{<>}^{<>} <>\\dd{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
          i(3),
          i(4),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- INTEGRAL from positive to negative infinity
    s(
      {
        trig = "([^%a])intf",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\int\\limits_{-\\infty}^{\\infty} <>\\dd{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          i(1),
          i(2),
        }
      ),
      { condition = tex.in_mathzone }
    ),
    -- BOXED command
    s(
      {
        trig = "([^%a])bb",
        wordTrig = false,
        regTrig = true,
        snippetType="autosnippet"
      },
      fmta(
        "<>\\boxed{<>}",
        {
          f(function(_, snip)
            return snip.captures[1]
          end),
          d(1, get_visual)
        }
      ),
      { condition = tex.in_mathzone }
    ),
    --
    -- BEGIN STATIC SNIPPETS
    --

    -- DIFFERENTIAL, i.e. \diff
    s(
      {
        trig = "df",
        snippetType="autosnippet",
        priority=2000,
      },
      {
        t("\\dd"),
      },
      { condition = tex.in_mathzone }
    ),
    -- BASIC INTEGRAL SYMBOL, i.e. \int
    s(
      {
        trig = "in1",
        snippetType="autosnippet"
      },
      {
        t("\\int"),
      },
      { condition = tex.in_mathzone }
    ),
    -- DOUBLE INTEGRAL, i.e. \iint
    s(
      {
        trig = "in2",
        snippetType="autosnippet"
      },
      {
        t("\\iint"),
      },
      { condition = tex.in_mathzone }
    ),
    -- TRIPLE INTEGRAL, i.e. \iiint
    s(
      {
        trig = "in3",
        snippetType="autosnippet"
      },
      {
        t("\\iiint"),
      },
      { condition = tex.in_mathzone }
    ),
    -- CLOSED SINGLE INTEGRAL, i.e. \oint
    s(
      {
        trig = "oi1",
        snippetType="autosnippet"
      },
      {
        t("\\oint"),
      },
      { condition = tex.in_mathzone }
    ),
    -- GRADIENT OPERATOR, i.e. \grad
    s(
      {
        trig = "gdd",
        snippetType="autosnippet"
      },
      {
        t("\\grad "),
      },
      { condition = tex.in_mathzone }
    ),
    -- CURL OPERATOR, i.e. \curl
    s(
      {
        trig = "cll",
        snippetType="autosnippet"
      },
      {
        t("\\curl "),
      },
      { condition = tex.in_mathzone }
    ),
    -- DIVERGENCE OPERATOR, i.e. \divergence
    s(
      {
        trig = "DI",
        snippetType="autosnippet"
      },
      {
        t("\\div "),
      },
      { condition = tex.in_mathzone }
    ),
    -- LAPLACIAN OPERATOR, i.e. \laplacian
    s(
      {
        trig = "laa",
        snippetType="autosnippet"
      },
      {
        t("\\laplacian "),
      },
      { condition = tex.in_mathzone }
    ),
    -- PARALLEL SYMBOL, i.e. \parallel
    s(
      {
        trig = "||",
        snippetType="autosnippet"
      },
      {
        t("\\parallel"),
      }
    ),
    -- CDOTS, i.e. \cdots
    s(
      {
        trig = "cdd",
        snippetType="autosnippet"
      },
      {
        t("\\cdots"),
      }
    ),
    -- LDOTS, i.e. \ldots
    s(
      {
        trig = "ldd",
        snippetType="autosnippet"
      },
      {
        t("\\ldots"),
      }
    ),
    -- EQUIV, i.e. \equiv
    s(
      {
        trig = "eqq",
        snippetType="autosnippet"
      },
      {
        t("\\equiv "),
      }
    ),
    -- APPROX, i.e. \approx
    s(
      {
        trig = "px",
        snippetType="autosnippet"
      },
      {
        t("\\approx "),
      },
      { condition = tex.in_mathzone }
    ),
    -- PROPTO, i.e. \propto
    s(
      {
        trig = "pt",
        snippetType="autosnippet"
      },
      {
        t("\\propto "),
      },
      { condition = tex.in_mathzone }
    ),
    -- IMPLIES, i.e. \implies
    s(
      {
        trig = ">>",
        snippetType="autosnippet"
      },
      {
        t("\\implies "),
      }
    ),
    -- DOT PRODUCT, i.e. \cdot
    s(
      {
        trig = ",.",
        snippetType="autosnippet"
      },
      {
        t("\\vdot "),
      }
    ),
    -- CROSS PRODUCT, i.e. \times
    s(
      {
        trig = "xx",
        snippetType="autosnippet"
      },
      {
        t("\\cp "),
      }
    ),
  }),
}
