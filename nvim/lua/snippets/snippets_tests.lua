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


return {
  ls.add_snippets("lua", {
    s("logc",
      fmt([[Debug.Log($"<color={}>{}</color>");]],
        {
          c(1,{
            t("red"),
            t("green"),
            t("blue"),
            t("cyan"),
            t("magenta"),
          }),
          i(2,"PLACE_HOLDER"),
        }
      )
    ),
  }),
}

-- End Refactoring
