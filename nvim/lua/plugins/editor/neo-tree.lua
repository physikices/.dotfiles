return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim",
  },


  config = function ()
    local icons = require("user-icons")
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = false,
        }
      },
      git_status = {
        symbols = {
          added = icons.git.LineAdded,
          modified = icons.git.LineModified,
          deleted = icons.git.LineRemoved,
          renamed = icons.git.FileRenamed,
          untracked = icons.git.FileUntracked,
          ignored = icons.git.FileIgnored,
          unstaged = icons.git.FileUnstaged,
          staged = icons.git.FileStaged,
          conflict = icons.git.FileConflict
        }
      }
    })
    vim.fn.sign_define("DiagnosticSignError",
      {text = " ", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn",
      {text = " ", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo",
      {text = " ", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint",
      {text = "󰌵", texthl = "DiagnosticSignHint"})
  end
}
