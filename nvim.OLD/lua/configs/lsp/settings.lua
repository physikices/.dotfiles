local on_attach = function(client, bufnr)
	local caps = client.server_capabilities
	local keymap = vim.keymap.set
	local opts = { noremap = true, silent = true }

	-- Enable completion triggered by <C-X><C-O>
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- tagfunc
	if caps.definitionProvider then vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc") end

	if client.supports_method "textDocument/formatting" then
		keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
		-- elseif client.server_capabilities.document_range_formatting then
		-- 	keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end



local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	snippetSupport = true,
	documentationFormat = { "markdown", "plaintext" },
	deprecatedSupport = true,
	labelDetailsSupport = true,
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}



local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if present then capabilities = cmp_nvim_lsp.default_capabilities(capabilities) end

local settings = {
	on_attach = on_attach,
	capabilities = capabilities,
}

return settings
