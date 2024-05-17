lvim.leader = "space"
-- Saving
vim.opt.confirm = true
-- Create / open a file in the current foleder
vim.api.nvim_set_keymap("n", "<c-e>", ":e " .. vim.fn.escape(vim.fn.expand("%:p:h"), " ") .. "/", { noremap = true })

-- Disabling how we move lines around so that we can give that key to yabai
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.lsp.buffer_mappings.normal_mode["gd"] = nil
lvim.keys.normal_mode["gd"] = ":Telescope lsp_definitions<CR>"
lvim.lsp.buffer_mappings.normal_mode["gk"] = lvim.lsp.buffer_mappings.normal_mode["K"]

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["c"] = { ":BDelete this<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["C"] = { "<C-w>q<CR>", "Close Split" }
lvim.builtin.which_key.mappings["n"] = { ":nohlsearch<CR>", "No Highlight" }
lvim.builtin.which_key.mappings["h"] = { ":bp<CR>", "Left Buffer" }
lvim.builtin.which_key.mappings["l"] = { ":bn<CR>", "Right Buffer" }
lvim.builtin.which_key.mappings["<leader>"] = { "<c-^>", "Recent file" }
lvim.builtin.which_key.mappings["bt"] = { ":enew<CR>", "New Buffer " }
lvim.builtin.which_key.mappings["gL"] = { ":Git blame<CR>", "Blame file" }
lvim.builtin.which_key.mappings["sg"] = { ":Telescope git_status<CR>", "Git Status" }
-- Can remove the following, but nice to have a little bit of customisation
lvim.builtin.which_key.mappings["sf"] = {
	"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>",
	"Find all files",
}

-- Buffers are annoying, go in through buffer -> find rather than search
lvim.builtin.which_key.mappings["w"] = { "<cmd>lua vim.lsp.buf.format()<CR>:w<CR>", "Format & Save" }
lvim.builtin.which_key.mappings["v"] = {
	name = "Virtual Env",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
	s = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
}

lvim.builtin.which_key.mappings["a"] = {
	name = "LSP",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	o = {
		"<cmd>OrganizeImports<cr>",
		"Organise Imports",
	},
	d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
	w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
	f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },
	i = { "<cmd>LspInfo<cr>", "Info" },
	I = { "<cmd>Mason<cr>", "Mason Info" },
	j = {
		"<cmd>lua vim.diagnostic.goto_next()<cr>",
		"Next Diagnostic",
	},
	n = {
		"<cmd>lua vim.diagnostic.goto_next()<cr>",
		"Next Diagnostic",
	},
	k = {
		"<cmd>lua vim.diagnostic.goto_prev()<cr>",
		"Prev Diagnostic",
	},
	p = {
		"<cmd>lua vim.diagnostic.goto_prev()<cr>",
		"Prev Diagnostic",
	},
	l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
	q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
	r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
	e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}

-- Clipboard
-- Allows the Neovim clipboard to work with the system clipboard
if vim.fn.has("nvim") == 0 then
	vim.opt.tlipboard = "unnamed"
end
vim.opt.clipboard:append("unnamedplus")
lvim.keys.normal_mode["p"] = "gp"
lvim.keys.normal_mode["P"] = "gP"
lvim.keys.normal_mode["gp"] = "p"
lvim.keys.normal_mode["gP"] = "P"

function navi(wincmd, direction)
	local previous_winnr = vim.fn.winnr()
	vim.cmd("wincmd " .. wincmd)

	if previous_winnr == vim.fn.winnr() then
		vim.fn.system("tmux-yabai.sh " .. direction)
	end
end

-- Navigating splits
lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('smart-splits').move_cursor_left()<CR>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('smart-splits').move_cursor_down()<CR>"
lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('smart-splits').move_cursor_up()<CR>"
lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('smart-splits').move_cursor_right()<CR>"
lvim.keys.normal_mode["<C-\\>"] = "<cmd>lua require('smart-splits').move_cursor_previous()<CR>"

-- resizing splits
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

-- swapping splits around
vim.keymap.set("n", "<C-A-h>", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<C-A-j>", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<C-A-k>", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<C-A-l>", require("smart-splits").swap_buf_right)

lvim.keys.normal_mode["vv"] = "<C-w>v"
lvim.keys.normal_mode["ss"] = "<C-w>s"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Buffers
-- Hide unwritten buffers instead of closing them
vim.hidden = true
