-- programs.lua
-- Equivalente às variáveis $terminal, $fileManager, etc. do hyprland.conf antigo.
--
-- IMPORTANTE: em Lua, `require()` roda cada arquivo em seu próprio escopo —
-- diferente do `source =` do hyprlang, que colava o conteúdo no mesmo namespace.
-- Por isso essas variáveis viram uma tabela retornada por module, e tanto
-- hyprland.lua quanto keybinds.lua fazem `require("programs")` para acessá-las.

local M = {}

M.terminal    = "foot"
M.fileManager = "dolphin"
M.menu        = "wofi --show drun"
-- M.menu     = os.getenv("HOME") .. "/.config/rofi/deathemonic/bin/launcher"
M.browser     = os.getenv("HOME") .. "/.config/.zen/zen"
M.editor      = "nvim"
M.screenlock  = "hyprlock"

return M
