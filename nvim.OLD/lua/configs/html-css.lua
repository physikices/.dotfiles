local present, htmlcss = pcall(require, "htmlcss")
if not present then return end

htmlcss.setup{
	option = {
		enable_on = {
			"html",
			"css",
			"scss",
			"typescript",
			"javascript",
			"vue",
		},
		file_extensions = {
			"css",
			"sass",
			"vue",
		}
	}
}
