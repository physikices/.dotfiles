return {
  dir = "~/.config/nvim/forks/feline.nvim",
  name = "feline.nvim",
  dependencies = { "catppuccin/nvim" }, -- garante ordem
  config = function ()
    local cat_ok, ctp = pcall(require, "catppuccin.integrations.feline")
    if cat_ok and type(ctp.setup) == "function" then
      pcall(ctp.setup) -- configura highlights, se disponível
    end

    local feline_ok, feline = pcall(require, "feline")
    if not feline_ok then
      -- se seu fork não estiver presente, evita crash silenciosamente
      return
    end

    -- tenta obter componentes via APIs possíveis
    local components = nil
    if cat_ok then
      if type(ctp.get) == "function" then
        components = ctp.get()
      elseif type(ctp.get_statusline) == "function" then
        components = ctp.get_statusline()
      end
    end

    require('feline').setup({
      components = components or {}, -- fallback: vazio
      options = {
        theme = 'catppuccin',
      }
    })
  end
}
