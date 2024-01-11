local function c(lhs, fun, opt) vim.api.nvim_create_user_command(lhs, fun, opt or {}) end

local function clean(files, msg)
	if vim.fn.confirm(msg, "&Yes\n&Abort") ~= 1 then
		return
	end

	for _,file in pairs(files) do
		local f = vim.fn.stdpath(file)
		if vim.fn.isdirectory(f) then
			vim.fn.delete(f, "rf")
			vim.notify("Cleaned '" .. f .. "'", vim.log.levels.INFO)
		end
	end
end

c("Nuke", function()
	clean({"cache", "data", "data_dirs", "log", "state"}, "Are you sure you wanna make things go boom boom?")
end)

c("Clean", function()
	clean({"cache", "log"}, "Are you sure you wanna clean tmp files?")
end)
