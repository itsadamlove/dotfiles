local M = {}

function M.setup()
	require("avante").setup({
		provider = "claude", -- or "openai", "copilot"
		ui = {
			width = 0.4,
			position = "right",
			border = "rounded",
		},
		-- Custom prompts
		prompts = {
			explain = "Please explain this code in detail:",
			fix = "Please identify and fix any issues in this code:",
			optimize = "Please optimize this code for better performance:",
			document = "Please add comprehensive documentation to this code:",
		},
	})
end

return M
