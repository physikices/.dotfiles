require "settings"

vim.schedule(function()
  require "autocmd"
  require "mapping"
  require "command"
end)

-- lazy load plugins
_G.lazy = function(plugin, timer)
	vim.defer_fn(function()
		require("packer").loader(plugin)
		if plugin == "nvim-lspconfig" then vim.cmd "silent! do FileType" end
	end, timer or 0)
end

-- lazy load plugins based on filetype
_G.lazyft = function(filetype, plugin, timer)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			vim.defer_fn(function() require("packer").loader(plugin) end, timer or 0)
		end,
	})
end

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.notify("Error: Packer is missing! Installing it...", vim.log.levels.WARN)
  vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

  vim.api.nvim_command "packadd packer.nvim"
  local present, packer = pcall(require, "packer")
  if present then
	 vim.notify("Packer was installed Successfully! Proceeding with plugins...", vim.log.levels.INFO)
	 vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#292c3c" })
	 require "plugins"
	 packer.sync()
	 vim.notify("Installation and setup completed", vim.log.levels.INFO)
  else
	 vim.notify("Failed to clone packer under " .. install_path, vim.log.levels.ERROR)
  end
end
