local auto_command_on = vim.api.nvim_create_autocmd

auto_command_on({ "BufRead", "BufNewFile" }, {
	pattern = { "*.podspec", "Podfile" },
	command = "set filetype=ruby",
})
