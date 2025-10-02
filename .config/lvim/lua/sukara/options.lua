-- Neovim core options
vim.opt.autoread = true -- reload files changed outside of vim
vim.opt.colorcolumn = "120" -- show column at 120 chars
vim.opt.ttimeoutlen = 10 -- fast <Esc>
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.relativenumber = true
vim.opt.spelllang = "en_au"
vim.opt.spell = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1
vim.opt.mousescroll = "ver:3,hor:4"
vim.opt.mousemoveevent = false
vim.opt.updatetime = 200

-- Keymaps (safe with LunarVim)
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

-- LunarVim specific config
lvim.log.level = "warn"
lvim.format_on_save = { enabled = true, timeout = 1000 }
vim.diagnostic.config({ virtual_text = false })
-- vim.notify = require("notify")

-- Builtin Dashboard on Start up
lvim.builtin.alpha.active = true

-- Parsers (Syntax / AST)
lvim.builtin.treesitter.ensure_installed = {
	"python",
	"bash",
	"javascript",
	"json",
	"lua",
	"typescript",
	"tsx",
	"css",
	"comment",
	"markdown_inline",
	"prisma",
	"regex",
	"graphql",
	"html",
	"vim",
	"yaml",
}

lvim.builtin.treesitter.autotag = { enable = true }

-- Use TreeSitter for highlighting
lvim.builtin.treesitter.highlight.enable = true

-- TODO: check this and maybe change the configuration
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

-- Diagnostics UI
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
