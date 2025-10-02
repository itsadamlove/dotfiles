-- Reload files changed outside of vime
vim.opt.autoread = true
-- Show column at 120 chars
vim.opt.colorcolumn = "120"
-- Fast esc key
vim.opt.ttimeoutlen = 10
-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.relativenumber = true
-- Spell Check
vim.opt.spelllang = "en_au"
vim.opt.spell = true
-- Swap Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wb = false
-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	-- pattern = "*.lua",
	timeout = 1000,
}

-- Wrapping
vim.opt.linebreak = true
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Scrolling
-- Scroll limits
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
