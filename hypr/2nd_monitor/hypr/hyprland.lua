-- hyprland.lua
-- Refatorado de hyprland.conf (hyprlang) para o novo formato Lua (Hyprland >= 0.55)
-- Docs: https://wiki.hypr.land/Configuring/Start/
--
-- Não estão incluídos aqui: valores não usados por hyprland.conf originalmente,
-- como as demais entradas de mocha.conf que só o hyprlock.conf consumia.

local mocha    = require("mocha")
local programs = require("programs")

------------------
---- MONITORES ----
------------------
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Reproduz os 2 monitores definidos no hyprland.conf original:
--   monitor = DVI-I-1, 1440x900, 0x0, 1
--   monitor = VGA-1, 1440x900, 1440x0, 1, transform, 1
-- No formato Lua, "transform" é um campo próprio da tabela (inteiro 0-7,
-- onde 1 = rotacionado 90°) em vez de um par extra "transform, 1" na linha.
hl.monitor({
    output   = "DVI-I-1",
    mode     = "1440x900",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output    = "VGA-1",
    mode      = "1440x900",
    position  = "1440x0",
    scale     = 1,
    transform = 1, -- 90°
})

-- Regra de fallback para qualquer outro monitor não listado acima
-- (equivalente a não ter tratamento explícito no .conf original, mas
-- recomendada pela wiki para evitar telas pretas em monitores extras)
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-------------------
---- AUTOSTART ----
-------------------
-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/waybar/script.sh")
end)

-------------------------------
---- VARIÁVEIS DE AMBIENTE ----
-------------------------------
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/Downloads/tmp_hyprshot")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in    = 2,
        gaps_out   = 5,
        border_size = 2,

        col = {
            -- eram: rgba(89b4faee) rgba(94e2d5ee) — correspondem a mocha.blue / mocha.teal
            active_border   = { colors = { "rgba(89b4faee)", "rgba(94e2d5ee)" }, angle = 0 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 10,

        active_opacity   = 1.0,
        inactive_opacity = 0.75,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
})

-- Curvas / animações — https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({ animations = { enabled = true } }) -- era: "enabled = yes, please :)"

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global",         enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",         enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",        enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",      enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",     enabled = true, speed = 1.49, bezier = "linear",        style = "popin 87%" })
hl.animation({ leaf = "fadeIn",         enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",        enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",           enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",         enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5,  bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",     enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only" — descomente se quiser usar
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1", match = { float = false, workspace = "f[1]" }, border_size = 0, rounding = 0 })

-- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        -- pseudotile = true, -- alternável com mainMod + P nos keybinds
        preserve_split = true,
    },
})

-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo   = false,
    },
})

-------------
---- INPUT ----
-------------
hl.config({
    input = {
        kb_layout  = "br",
        kb_model   = "",
        kb_variant = "",
        kb_options = "caps:swapescape",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0, -- -1.0 - 1.0, 0 = sem modificação

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- gestures = { workspace_swipe = true } -- estava comentado no original

-- Config de dispositivo por exemplo
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------------
---- ATALHOS DE TECLADO ----
---------------------------
require("keybinds")

-- Teclas multimídia do notebook para volume e brilho da tela
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requer playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })

------------------------------------
---- JANELAS E WORKSPACES ----
------------------------------------
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- windowrule v1/v2 de exemplo (comentados no original)
-- hl.window_rule({ name = "float-kitty", match = { class = "^(kitty)$" }, float = true })
-- hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
-- hl.window_rule({ name = "fix-xwayland-drag", match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })

hl.window_rule({
    name  = "apply-something",
    match = { class = "my-window" },
    border_size = 10,
})
