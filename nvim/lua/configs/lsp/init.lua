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
		"prettier",
		"prettierd",

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
		"lua_ls",
		"fortls",
		-- "ltex",
		"texlab",
		"tsserver",
		"jsonls",
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

	["lua_ls"] = function()
		lsp.lua_ls.setup({
			settings = {
				Lua ={
					runtime = {
						version = 'LuaJIT',
						path = vim.split(package.path, ";"),
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
						checkThirdParty = false,
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
				'--source_dirs',
				'--autocomplete_no_snippets',
				'--lowercase_intrinsics'
			},
			filetypes = {"fortran"},
			docs = {
				vscode = "hansec.fortran-ls",
				default_config = {
					root_dir = [[root_pattern(".fortls")]]
				}
			},
			settings = {
				nthreads = 1,
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
			root_dir = vim.loop.os_homedir,
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
	["jsonls"] = function ()
		lsp.jsonls.setup(opt{
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = {enable = true},
				},
			},
		})
	end,
	["tsserver"] = function ()
		lsp.tsserver.setup({
			cmd = {"typescript-language-server", "--stdio"},
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx"
			},
			root_dir = require "lspconfig/util".root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
		})
	end
}

