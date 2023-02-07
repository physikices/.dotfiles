require "configs.lsp.handlers" -- diagnostics' settings
local S = require "configs.lsp.settings" -- default server settings (i.e. capabilities and attachments)

local present, mason = pcall(require, "mason")
if not present then return end

mason.setup {
  ui = {
	 icons = {
		package_pending = " ",
		package_installed = " ",
		package_uninstalled = " ",
	 },
	 keymaps = {
		toggle_server_expand = "<CR>",
		install_server = "i",
		update_server = "u",
		uninstall_server = "x",
		check_server_version = "c",
		update_all_servers = "U",
		check_outdated_servers = "C",
		cancel_installation = "<C-c>",
	 },
  },
  max_concurrent_installers = 5,
  install_root_dir = vim.fn.stdpath "data" .. require("utils").path_separator .. "pkgs",
}

require("mason-tool-installer").setup {
  ensure_installed = {
	 -- formatters
	 "stylua",

	 -- linters
	 -- "ltex-ls",
	 "texlab",
  },
  auto_update = false,
  run_on_start = true,
}

-- make nvim-lspconfig recognize mason-installed servers
-- refer to: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup {
  ensure_installed = {
	 "sumneko_lua",
	 "fortls",
	 -- "ltex",
	 "texlab",
  },
  automatic_installation = true,
}


local available, lsp = pcall(require, "lspconfig")
if not available then return end

local function opt(opts) return vim.tbl_deep_extend("force", S, opts or {}) end

-- make mason setup the servsers
mason_lspconfig.setup_handlers {
  function(server) -- default handler
	 lsp[server].setup(S)
	 -- same as passing {
	 -- on_attach = S.on_attach,
	 -- capabilities = S.capabilities,
	 -- }
  end,

  ["sumneko_lua"] = function()
	 lsp.sumneko_lua.setup({
		settings = {
		  Lua ={
			 runtime = {
				version = 'LuaJIT',
				path = runtime_path,
			 },
			 completion = {
				callSnippet = 'Replace',
			 },
			 diagnostics = {
				enable = true,
				globals = {'vim', 'use'},
			 },
			 workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				maxPreload = 10000,
				preloadFileSize = 10000,
			 },
			 telemetry = {enable = false},
		  },
		}
	 })
  end,

  ["fortls"] = function()
	 lsp.fortls.setup({
		cmd = {
		  'fortls',
		  '--notify_init',
		  '--hover_signature',
		  '--hover_language=fortran',
		  '--use_signature_help',
		  '--incremental_sync',
		  '--sort_keywords',
		  '--source_dirs'
		},
	 })
  end,

  --[[ ["ltex"] = function ()
	 lsp.ltex.setup({
		cmd = { "ltex-ls" },
		filetypes = {
		  "bib",
		  "gitcommit",
		  "markdown",
		  "org",
		  "plaintex",
		  "rst",
		  "rnoweb",
		  "tex"
		},
	 })
  end, ]]

  ["texlab"] = function ()
	 lsp.texlab.setup({
		cmd = { "texlab" },
		filetypes = {
		  "tex",
		  "plaintex",
		  "bib"
		},
		settings = {
		  texlab = {
			 auxDirectory = ".",
			 bibtexFormatter = "texlab",
			 build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = false
			 },
			 chktex = {
				onEdit = false,
				onOpenAndSave = false
			 },
			 diagnosticsDelay = 300,
			 formatterLineLength = 80,
			 forwardSearch = {
				args = {}
			 },
			 latexFormatter = "texlab",
			 latexindent = {
				modifyLineBreaks = false
			 },
		  },
		},
	 })
  end,
}

