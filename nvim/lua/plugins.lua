local present, packer = pcall(require, "packer")
if not present then return end

packer.init {
	auto_reload_compiled = true,
	compile_on_sync = true,
	git = { clone_timeout = 6000 },
	display = {
		open_fn = function() return require("packer.util").float { border = "single" } end,
	},
}

local use = function(plugin)
	return function(opts)
		opts = opts or {}
		if not opts[1] or vim.fn.isdirectory(vim.fn.expand(opts[1])) == 0 then opts[1] = plugin end
		if type(opts.config) == "string" then opts.config = "require'" .. opts.config .. "'" end
		if type(opts.setup) == "string" then opts.setup = "lazy'" .. opts.setup .. "'" end
		if opts.setup then opts.opt = true end
		packer.use(opts)
	end
end

-- deps
use "nvim-lua/plenary.nvim" { module = "plenary" }
use "nvim-treesitter/nvim-treesitter" {
	module = "nvim-treesitter",
	event = "VimEnter",
	run = ":TSUpdate",
	config = "configs.treesitter",
}

use "kyazdani42/nvim-web-devicons" { module = "nvim-web-devicons" }
use "catppuccin/nvim" {
	-- "~/dev/catppuccin/nvim",
	as = "catppuccin",
	config = "configs.catppuccin",
	-- event = "VimEnter",
	-- run = ":CatppuccinCompile",
}

-- ui
use "feline-nvim/feline.nvim" {
	after = "catppuccin",
	config = "configs.feline",
}

use "akinsho/bufferline.nvim" {
	after = "catppuccin",
	config = "configs.bufferline",
}

use "lukas-reineke/indent-blankline.nvim" {
	after = "catppuccin",
	config = "configs.indent_blankline",
}

use "kyazdani42/nvim-tree.lua" {
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	config = "configs.nvimtree",
}

use "NvChad/nvim-colorizer.lua" {
	config = function()
		--require("colorizer").setup()
		require("colorizer").attach_to_buffer(0)
	end,
	setup = "nvim-colorizer.lua",
}

-- lsp
use "neovim/nvim-lspconfig" {
	setup = "nvim-lspconfig",
	wants = {
		"mason.nvim",
		"mason-lspconfig.nvim",
		"mason-tool-installer.nvim",
		"cmp-nvim-lsp",
		"schemastore.nvim",
	},
	config = "configs.lsp",
	requires = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"b0o/schemastore.nvim",
	},
}
use "glepnir/lspsaga.nvim" { after = "nvim-lspconfig", config = "configs.lsp.saga" }
-- cmp
use "hrsh7th/nvim-cmp" {
	module = "cmp",
	event = "InsertEnter",
	requires = {
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "ray-x/cmp-treesitter", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
		{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
		{ "f3fora/cmp-spell", after = "nvim-cmp" },
		{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
		{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
		{
			"L3MON4D3/LuaSnip",
			wants = "friendly-snippets",
			config = function() require "configs.cmp.luasnip" end,
		},
		"rafamadriz/friendly-snippets",
	},
	config = "configs.cmp",

}
-- autopair
use "windwp/nvim-autopairs" {
	after = "nvim-cmp",
	config = function()
		require("nvim-autopairs").setup()
		require("cmp").event:on("confirm_done",
			require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}

-- tools
use "numToStr/Comment.nvim" {
	module = "Comment",
	keys = { "gc", "gb" },
	config = function() require("Comment").setup {} end,
}

use "Pocco81/true-zen.nvim" {
	branch = "dev",
	event = "BufReadPost",
	config = "configs.truezen",
}

-- git
use "TimUntersberger/neogit" {
	cmd = "Neogit",
	config = function() require("neogit").setup {} end,
}
use "lewis6991/gitsigns.nvim" {
	--config = function() require "configs.gitsigns" end,
	config = "configs.gitsigns",
	setup = function()
		if vim.fn.isdirectory ".git" ~= 0 then lazy "gitsigns.nvim" end
	end,
}

-- File manager
use "nvim-telescope/telescope.nvim" {
	module = "telescope",
	cmd = "Telescope",
	config = function() require("telescope").setup() end,
}
use "nvim-telescope/telescope-fzf-native.nvim" {
	after = "telescope.nvim",
	run = "make",
	config = function() require("telescope").load_extension "fzf" end,
}

use "nvim-neotest/neotest-plenary" {}

use "nvim-neotest/neotest" {
	config = function()
		require("neotest").setup {
			adapters = {
				require "neotest-plenary",
			},
		}
	end,
}

-- misc
use "wbthomason/packer.nvim" {
	cmd = {
		"PackerSnapshot",
		"PackerSnapshotRollback",
		"PackerSnapshotDelete",
		"PackerInstall",
		"PackerUpdate",
		"PackerSync",
		"PackerClean",
		"PackerCompile",
		"PackerStatus",
		"PackerProfile",
		"PackerLoad",
	},
	config = "plugins",
}

use "gpanders/editorconfig.nvim" {
	event = "BufRead",
}

-- plugins em teste
use "rmagatti/alternate-toggler"{
	config = function ()
		require("alternate-toggler").setup{
			alternates = {
				["=="] = "!=",
			}
		}
	end,
	event = { "BufReadPost" },
}

use "akinsho/toggleterm.nvim" {
	tag = '*',
	config = "configs.toggleterm",
}

use "lervag/vimtex" {
	config = "configs.vimtex",
}
