-- mocha.lua
-- Paleta Catppuccin Mocha, convertida de mocha.conf.
--
-- NOTA: mocha.conf (formato hyprlang) foi mantido intacto porque o hyprlock
-- ainda não migrou para Lua e continua fazendo `source = mocha.conf`.
-- Este módulo é só para uso dentro do hyprland.lua / keybinds.lua.

local M = {}

-- Cor "rgb(...)" pronta para usar em campos de cor do hl.config / hl.window_rule
M.rosewater = "rgb(f5e0dc)"
M.flamingo  = "rgb(f2cdcd)"
M.pink      = "rgb(f5c2e7)"
M.mauve     = "rgb(cba6f7)"
M.red       = "rgb(f38ba8)"
M.maroon    = "rgb(eba0ac)"
M.peach     = "rgb(fab387)"
M.yellow    = "rgb(f9e2af)"
M.green     = "rgb(a6e3a1)"
M.teal      = "rgb(94e2d5)"
M.sky       = "rgb(89dceb)"
M.sapphire  = "rgb(74c7ec)"
M.blue      = "rgb(89b4fa)"
M.lavender  = "rgb(b4befe)"
M.text      = "rgb(cdd6f4)"
M.subtext1  = "rgb(bac2de)"
M.subtext0  = "rgb(a6adc8)"
M.overlay2  = "rgb(9399b2)"
M.overlay1  = "rgb(7f849c)"
M.overlay0  = "rgb(6c7086)"
M.surface2  = "rgb(585b70)"
M.surface1  = "rgb(45475a)"
M.surface0  = "rgb(313244)"
M.base      = "rgb(1e1e2e)"
M.mantle    = "rgb(181825)"
M.crust     = "rgb(11111b)"

-- Hex "cru" (sem rgb()), útil para montar strings rgba(HEXALPHA) manualmente,
-- equivalente às variáveis $xxxAlpha do mocha.conf original
M.hex = {
    rosewater = "f5e0dc", flamingo = "f2cdcd", pink = "f5c2e7", mauve = "cba6f7",
    red = "f38ba8", maroon = "eba0ac", peach = "fab387", yellow = "f9e2af",
    green = "a6e3a1", teal = "94e2d5", sky = "89dceb", sapphire = "74c7ec",
    blue = "89b4fa", lavender = "b4befe", text = "cdd6f4", subtext1 = "bac2de",
    subtext0 = "a6adc8", overlay2 = "9399b2", overlay1 = "7f849c", overlay0 = "6c7086",
    surface2 = "585b70", surface1 = "45475a", surface0 = "313244", base = "1e1e2e",
    mantle = "181825", crust = "11111b",
}

return M
