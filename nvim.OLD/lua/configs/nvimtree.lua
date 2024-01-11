local present, nvimtree = pcall(require, "nvim-tree")
if not present then return end

nvimtree.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	sync_root_with_cwd = true,
	view = {
		width = 25,
		side = "left",
		-- hide_root_folder = false, --> deprecated
	},
	git = {
		enable = false,
		ignore = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		root_folder_label = true,
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = " ",
					open = " ",
					empty = " ",
					empty_open = " ",
					symlink = " ",
					symlink_open = " ",
				},
				git = {
					unstaged = "✗",
					staged = "",
					unmerged = "",
					renamed = "",
					untracked = "",
					deleted = "﯊",
					ignored = "",
				},
			},
		},
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
	},
}
