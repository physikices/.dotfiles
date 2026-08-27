-- keybinds.lua
-- Refatorado de keybinds.conf
-- Ref: https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("programs")

local mainMod = "ALT" -- era: $mainMod = Alt

-- Binds de exemplo
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exit()) -- estava comentado no original
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind("SUPER + J", hl.dsp.layout("togglesplit")) -- dwindle (nota: SUPER aqui, não mainMod — igual no original)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(programs.screenlock))

-- Mover foco com mainMod + teclas vim
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Mover janelas com mainMod + SHIFT + teclas vim
-- ATENÇÃO: não achei confirmação 100% oficial de que window.move aceita
-- `direction` (só vi exemplos com `workspace`/`window`). Se o reload reclamar,
-- verifique com `hyprctl reload` + o log, ou o stub em /usr/share/hypr/stubs/hl.meta.lua
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Redimensionar janelas com mainMod + CTRL + teclas vim
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Navegar workspaces com SUPER + h/l (cria workspace se não existir — era "workspace,+1"/"-1")
hl.bind("SUPER + L", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + H", hl.dsp.focus({ workspace = "-1" }))

-- Trocar de workspace com mainMod + [0-9] / mover janela com mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 mapeia para a tecla 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace especial de exemplo (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Rolar pelos workspaces existentes com mainMod + scroll do mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mover/redimensionar janelas com mainMod + botão esquerdo/direito do mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Captura de tela de uma região
-- ATENÇÃO / BUG HERDADO DO ORIGINAL: `$shiftMod` nunca foi definido em nenhum
-- dos seus arquivos .conf. Em hyprlang, variável indefinida vira string vazia,
-- ou seja, esse bind sempre funcionou SEM modificador (só a tecla Print).
-- Troquei aqui para refletir esse comportamento real — ajuste para o
-- modificador que você realmente queria (ex.: "SHIFT + Print").
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))

-- Alternar (reiniciar) a waybar
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-- USER Scripts
-- NOTA: este exec-once de "dunst" é duplicado — já existe outro no
-- hyprland.lua (bloco de autostart). Mantive os dois para fidelidade, mas
-- provavelmente você só precisa de um.
hl.on("hyprland.start", function()
    hl.exec_cmd("dunst")
end)

-- Cloudrive <-> Localdrive
-- (bind comentado no original, mantido comentado)
-- hl.bind("F9", hl.dsp.exec_cmd("foot -e " .. os.getenv("HOME") .. "/Scripts/sync-remotes.sh proton-remote: " .. os.getenv("HOME") .. "/.servers/proton-ppgf"))

-- Localdrive -> Cloudrive

hl.bind("F11", hl.dsp.exec_cmd("foot -e " .. os.getenv("HOME") .. "/scripts/rclone-client.sh " .."Gdrive-ppgfClientPhysikices: " .. os.getenv("HOME") .. "/.servers/local_physikices"))
