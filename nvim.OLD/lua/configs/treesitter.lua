local present, treesitter = pcall(require, "nvim-treesitter.configs")
if not present then return end

treesitter.setup {
	ensure_installed = { "lua", "fortran", "python", "bash", "cpp", "javascript", "typescript", "html", "css", "markdown", "vim" },
	auto_install = true, -- auto install as soon as you open a "new" filetype
	ignore_install = { "tex", "latex" },
	highlight = {
		enable = true,
		use_languagetree = true,
		disable = { "tex", "latex" }
	},
   indent = {
	 enable = true,
	 disable = {}
   },
	 autotag = {
    enable = true
  },
}
