return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              -- Scroll preview window
              ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            },
            n = {
              ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            },
          },
        },
      })

      -- Keymaps for telescope builtins
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
