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
--
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  ls.add_snippets("tex", {
    s({ trig = ";a", snippetType = "autosnippet" }, {
      t("\\alpha"),
    }),
    s({ trig = ";b", snippetType = "autosnippet" }, {
      t("\\beta"),
    }),
    s({ trig = ";g", snippetType = "autosnippet" }, {
      t("\\gamma"),
    }),
    s({ trig = ";G", snippetType = "autosnippet" }, {
      t("\\Gamma"),
    }),
    s({ trig = ";d", snippetType = "autosnippet" }, {
      t("\\delta"),
    }),
    s({ trig = ";D", snippetType = "autosnippet" }, {
      t("\\Delta"),
    }),
    s({ trig = ";e", snippetType = "autosnippet" }, {
      t("\\epsilon"),
    }),
    s({ trig = ";ve", snippetType = "autosnippet" }, {
      t("\\varepsilon"),
    }),
    s({ trig = ";z", snippetType = "autosnippet" }, {
      t("\\zeta"),
    }),
    s({ trig = ";h", snippetType = "autosnippet" }, {
      t("\\eta"),
    }),
    s({ trig = ";o", snippetType = "autosnippet" }, {
      t("\\theta"),
    }),
    s({ trig = ";vo", snippetType = "autosnippet" }, {
      t("\\vartheta"),
    }),
    s({ trig = ";O", snippetType = "autosnippet" }, {
      t("\\Theta"),
    }),
    s({ trig = ";k", snippetType = "autosnippet" }, {
      t("\\kappa"),
    }),
    s({ trig = ";l", snippetType = "autosnippet" }, {
      t("\\lambda"),
    }),
    s({ trig = ";L", snippetType = "autosnippet" }, {
      t("\\Lambda"),
    }),
    s({ trig = ";m", snippetType = "autosnippet" }, {
      t("\\mu"),
    }),
    s({ trig = ";n", snippetType = "autosnippet" }, {
      t("\\nu"),
    }),
    s({ trig = ";x", snippetType = "autosnippet" }, {
      t("\\xi"),
    }),
    s({ trig = ";X", snippetType = "autosnippet" }, {
      t("\\Xi"),
    }),
    s({ trig = ";i", snippetType = "autosnippet" }, {
      t("\\pi"),
    }),
    s({ trig = ";I", snippetType = "autosnippet" }, {
      t("\\Pi"),
    }),
    s({ trig = ";r", snippetType = "autosnippet" }, {
      t("\\rho"),
    }),
    s({ trig = ";s", snippetType = "autosnippet" }, {
      t("\\sigma"),
    }),
    s({ trig = ";S", snippetType = "autosnippet" }, {
      t("\\Sigma"),
    }),
    s({ trig = ";t", snippetType = "autosnippet" }, {
      t("\\tau"),
    }),
    s({ trig = ";f", snippetType = "autosnippet" }, {
      t("\\phi"),
    }),
    s({ trig = ";vf", snippetType = "autosnippet" }, {
      t("\\varphi"),
    }),
    s({ trig = ";F", snippetType = "autosnippet" }, {
      t("\\Phi"),
    }),
    s({ trig = ";c", snippetType = "autosnippet" }, {
      t("\\chi"),
    }),
    s({ trig = ";p", snippetType = "autosnippet" }, {
      t("\\psi"),
    }),
    s({ trig = ";P", snippetType = "autosnippet" }, {
      t("\\Psi"),
    }),
    s({ trig = ";w", snippetType = "autosnippet" }, {
      t("\\omega"),
    }),
    s({ trig = ";W", snippetType = "autosnippet" }, {
      t("\\Omega"),
    }),
    s({ trig = "...", snippetType = "autosnippet" }, {
      t("\\cdots"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "v..", snippetType = "autosnippet" }, {
      t("\\vdots"),
    }, { condition = tex.in_mathzone }),
    s({ trig = "d..", snippetType = "autosnippet" }, {
      t("\\ddots"),
    }, { condition = tex.in_mathzone }),
  }),
}
