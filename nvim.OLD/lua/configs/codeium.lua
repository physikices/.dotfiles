local present, codeium = pcall(require, "codeium")
if not present then
	return
end

codeium.setup{
	formatting = {
		format = require('lspkind').cmp_format({
			mode = "symbol",
			maxwidth = 50,
			ellipsis_char = '...',
			symbol_map = { Codeium = "", }
		})
	},
}
