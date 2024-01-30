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
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      window = {
        mappings = {
          ["b"] = {
            'open_vsplit',
            desc = "Same than 'open_split' but with a vertical split",
          },
          ["B"] = {
            'open_split',
            desc = "Same than 'open_vsplit' but with a hotizontal split",
          },
          ["s"] = 'noop',
          ["S"] = 'noop',
        }
      },
      filesystem = {
        filtered_items = {
          -- visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = true,
          hide_gitignored = true,
        }
      },
      default_component_configs = {
        icon = {
          folder_closed = icons.ui.Folder,
          folder_open = icons.ui.FolderOpen,
          folder_empty = icons.ui.EmptyFolderOpen,
          default = icons.ui.File,
          highlight = "NeoTreeFileIcon"
        },
        modified = {
          symbol = icons.ui.NewFile,
          highlight = "NeoTreeModified",
        },
        git_status = {
          symbols = {
            added = icons.git.FileUntracked,
            modified = icons.git.LineModified,
            deleted = icons.git.FileDeletedRemoved,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            ignored = icons.git.FileIgnored,
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            conflict = icons.git.FileConflict
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
        }
      },
    })
    vim.fn.sign_define("DiagnosticSignError",
      {text = icons.diagnostics.Error, texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn",
      {text = icons.diagnostics.Warning, texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo",
      {text = icons.diagnostics.Information, texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint",
      {text = icons.diagnostics.Hint, texthl = "DiagnosticSignHint"})
  end
}
