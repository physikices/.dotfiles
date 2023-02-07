-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------
-- Summary: When `SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
	 return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
	 return sn(nil, i(1))
  end
end
-- ----------------------------------------------------------------------------

return {
  -- Example: italic font implementing visual selection
  s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", snippetType="autosnippet" },
	 fmta("\\textit{<>}",
		{
		  d(1, get_visual),
		}
	 )
  ),
}
