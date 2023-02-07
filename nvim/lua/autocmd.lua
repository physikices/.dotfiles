local a = vim.api.nvim_create_autocmd

a("VimLeave", {
	pattern = "*",
	desc = "reset the cursor to I-Beam (`|`)",
	callback = function() vim.o.guicursor = "a:ver24" end,
})

a("BufWritePost", {
	pattern = "*.editorconfig",
	desc = "refresh all buffers config on .editorconfig after it's saved",
	callback = function()
		local present, ec = pcall(require, "editorconfig")
		if not present then return end
		for _, buf in pairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) then ec.config(buf) end
		end
	end,
})
