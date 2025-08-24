return {

  'MeanderingProgrammer/render-markdown.nvim',

  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ---@module 'render-markdown'

  opts = {

    latex = {
      enabled = true,
      render_modes = false,
      converter = 'latex2text',
      highlight = 'RenderMarkdownMath',
      position = 'above',
      top_pad = 0,
      bottom_pad = 0,
    },

    anti_conceal = {
      enabled = true,
      disabled_modes = false,
      above = 0,
      below = 0,
      -- Which elements to always show, ignoring anti conceal behavior. Values can either be
      -- booleans to fix the behavior or string lists representing modes where anti conceal
      -- behavior will be ignored. Valid values are:
      --   bullet
      --   callout
      --   check_icon, check_scope
      --   code_background, code_border, code_language
      --   dash
      --   head_background, head_border, head_icon
      --   indent
      --   link
      --   quote
      --   sign
      --   table_border
      --   virtual_lines
      ignore = {
        code_background = true,
        indent = true,
        sign = true,
        virtual_lines = true,
      },
    },
  },
}
