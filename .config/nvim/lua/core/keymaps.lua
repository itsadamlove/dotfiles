local vim = vim
local fn = vim.fn

-- Remap leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Display the status bar always
vim.opt.laststatus = 2

-- Show incomplete commands in status bar
vim.opt.showcmd = true

-- Reload files changed outside of vime
vim.opt.autoread = true

-- Show column at 120 chars
vim.opt.colorcolumn = "120"

-- Fast esc key
vim.opt.ttimeoutlen = 10

-- Tabs have width of 2, uses spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smarttab = true

-- Searching
-- Map leader n to clear any highlights
vim.keymap.set("n", "<leader>n", ":nohlsearch<CR>")
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Spell Check
vim.opt.spelllang = "en_au"
vim.opt.spell = true

-- Swap Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.wb = false

-- Clipboard
-- Allows the Neovim clipboard to work with the system clipboard
if vim.fn.has("nvim") == 0 then
	vim.opt.clipboard = "unnamed"
end

vim.opt.clipboard:append("unnamedplus")

-- TODO: pasting is fucking everything
-- Remap pasting in Neovim so cursor doesn't go haywire
vim.keymap.set("n", "p", "gp")
vim.keymap.set("n", "P", "gP")
vim.keymap.set("n", "gp", "p")
vim.keymap.set("n", "gP", "P")

-- Move the current file elsewhere
vim.api.nvim_set_keymap(
	"n",
	"<Leader>r",
	":Move " .. vim.fn.fnameescape(vim.fn.expand("%:p:h")) .. "/",
	{ noremap = true }
)

--- Split Navigation
vim.keymap.set("n", "vv", "<C-W>v")
vim.keymap.set("n", "ss", "<C-W>s")
vim.keymap.set("n", "W", "<C-W>q")
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indenting
vim.keymap.set("n", "<leader>=", "gg=G``")

-- Wrapping
vim.opt.linebreak = true
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Scrolling
-- Scroll limits
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 1

-- Buffers
-- Hide unwritten buffers instead of closing them
vim.hidden = true
-- vim.keymap.set("n", "<leader>l", ":bn<CR>")
-- vim.keymap.set("n", "<leader>h", ":bp<CR>")
-- Close current buffer but keep split (from vimBufKill)
vim.keymap.set("n", "<leader>w", ":BDelete this<CR>")
-- Close all buffers
vim.keymap.set("n", "<leader>q", ":bufdo bdelete<CR>")
-- Open a new, empty buffer
vim.keymap.set("n", "<leader>t", ":enew<CR>")
-- vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- Saving
vim.opt.confirm = true
vim.keymap.set("", "<leader>s", ":w<CR>")
-- Create / open a file in the current foleder
vim.api.nvim_set_keymap("n", "<c-e>", ":e " .. vim.fn.escape(vim.fn.expand("%:p:h"), " ") .. "/", { noremap = true })

-- Commenting
vim.keymap.set("n", "<leader>c<leader>", ":CommentToggle <cr>")
vim.keymap.set("v", "<leader>c<leader>", ":CommentToggle <cr>")
