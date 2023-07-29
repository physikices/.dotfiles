local present, notify = pcall(require, "notify")
if not present then return end


notify.setup {
  -- Animation style
  stages = "fade_in_slide_out",
  -- Default timeout for notifications
  timeout = 1500,
  background_colour = "#1E1E2E",
	level = vim.log.levels.INFO,
}

vim.notify = notify

