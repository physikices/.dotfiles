return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "catppuccin/nvim" }, -- garante ordem
    event = "VeryLazy", -- carrega mais tarde (evita load prematuro)
    config = function ()
      local catppuccin_ok, cb = pcall(require, "catppuccin.integrations.bufferline")
      local highlights = nil
      if catppuccin_ok then
        -- cover both possible APIs
        if type(cb.get) == "function" then
          highlights = cb.get()
        elseif type(cb.get_theme) == "function" then
          highlights = cb.get_theme()
        end
      end

      require("bufferline").setup({
        highlights = highlights,
        options = {
          close_command = "bp|sp|bn|bd! %d",
          right_mouse_command = "bp|sp|bn|bd! %d",
          left_mouse_command = "buffer %d",
          buffer_close_icon = "",
          modified_icon = "",
          close_icon = "",
          show_close_icon = false,
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 14,
          max_prefix_length = 13,
          tab_size = 10,
          show_tab_indicators = true,
          enforce_regular_tabs = false,
          view = "multiwindow",
          show_buffer_close_icons = true,
          separator_style = "slant",
          always_show_bufferline = true,
          diagnostics = false,
          themable = true,
        },
      })
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require'window-picker'.setup({})
    end,
  },
}
