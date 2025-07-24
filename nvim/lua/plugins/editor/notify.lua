return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")

    -- Usa paleta mocha do Catppuccin com fallback
    local cp_ok, cp = pcall(require, "catppuccin.palettes")
    cp = cp_ok and cp.get_palette("mocha") or { base = "#1e1e2e" }

    -- Configuração principal do notify
    notify.setup({
      stages = "slide", -- ou slide, static, fade_in_slide_out
      timeout = 3000,
      background_colour = cp.base, -- fundo translúcido compatível
      render = "default",
      fps = 60,
      top_down = true,
    })

    -- Define como handler padrão do Neovim
    vim.notify = notify

    -- Integração com LSP
    local lsp = vim.lsp
    lsp.handlers["window/showMessage"] = function(_, result, ctx)
      local client = lsp.get_client_by_id(ctx.client_id)
      local level = ({
        "ERROR",
        "WARN",
        "INFO",
        "DEBUG",
      })[result.type] or "INFO"

      notify(result.message, level:lower(), {
        title = "LSP | " .. client.name,
        timeout = 5000,
        keep = false,
      })
    end
  end,
}
