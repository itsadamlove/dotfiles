lvim.leader = "space"
-- Saving
vim.opt.confirm = true
-- vim.keymap.set("", "<leader>s", ":w<CR>")
-- Create / open a file in the current foleder
vim.api.nvim_set_keymap("n", "<c-e>", ":e " .. vim.fn.escape(vim.fn.expand("%:p:h"), " ") .. "/", { noremap = true })

-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["c"] = { ":BDelete this<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["C"] = { "<C-w>q<CR>", "Close Split" }
lvim.builtin.which_key.mappings["n"] = { ":nohlsearch<CR>", "No Highlight" }
lvim.builtin.which_key.mappings["h"] = { ":bp<CR>", "Left Buffer" }
lvim.builtin.which_key.mappings["l"] = { ":bn<CR>", "Right Buffer" }
lvim.builtin.which_key.mappings["<leader>"] = { "<c-^>", "Recent file" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["bt"] = { ":enew<CR>", "New Buffer " }
lvim.builtin.which_key.mappings["gL"] = { ":Git blame<CR>", "Blame file" }
lvim.builtin.which_key.mappings["sg"] = { ":Telescope git_status<CR>", "Git Status" }
lvim.builtin.which_key.mappings["sF"] = { ":Telescope git_status<CR>", "Find Tracked Files" }
lvim.builtin.which_key.mappings["sb"] = { ":Telescope buffers<CR>", "Buffers" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>lua vim.lsp.buf.format()<CR>:w<CR>", "Format & Save" }
-- TODO: move this into an action of some sort
-- vim.lsp.buf.format()

lvim.builtin.which_key.mappings["a"] = {
	name = "LSP",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
	o = {
		"<cmd>lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguements = { vim.fn.expand('%:p')}})<cr>",
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

--- Split Navigation
lvim.keys.normal_mode["<C-h>"] = "<C-w>h"
lvim.keys.normal_mode["<C-j>"] = "<C-w>j"
lvim.keys.normal_mode["<C-k>"] = "<C-w>k"
lvim.keys.normal_mode["<C-l>"] = "<C-w>l"
lvim.keys.normal_mode["vv"] = "<C-w>v"
lvim.keys.normal_mode["ss"] = "<C-w>s"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- Buffers
-- Hide unwritten buffers instead of closing them
vim.hidden = true