lvim.leader = "space"

-- Remember that you can move lines around with the alt-j alt-k keys
-- Remember that the floating terminal is at ctrl \

-- Saving
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Split helpers
lvim.keys.normal_mode["vv"] = "<C-w>v"
lvim.keys.normal_mode["ss"] = "<C-w>s"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Keep buffers hidden instead of forced close
vim.opt.hidden = true

-- Create/open a file in the current dir
vim.keymap.set(
	"n",
	"<C-e>",
	":e " .. vim.fn.escape(vim.fn.expand("%:p:h"), " ") .. "/",
	{ noremap = true, silent = true, desc = "Edit in current dir" }
)

-- LSP motions via Telescope
local tb = require("telescope.builtin")
vim.keymap.set("n", "gd", tb.lsp_definitions, { desc = "Go to definition (Telescope)", silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", silent = true })
vim.keymap.set("n", "gi", tb.lsp_implementations, { desc = "Go to implementation (Telescope)", silent = true })
vim.keymap.set("n", "gr", tb.lsp_references, { desc = "References (Telescope)", silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", silent = true })

-- Diagnostic nav
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic", silent = true })

-- Alternate file (quick toggle)
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Alternate file", silent = true })

-- Smart-splits navigation (Ctrl+hjkl)
lvim.keys.normal_mode["<C-h>"] = "<cmd>lua require('smart-splits').move_cursor_left()<CR>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('smart-splits').move_cursor_down()<CR>"
lvim.keys.normal_mode["<C-k>"] = "<cmd>lua require('smart-splits').move_cursor_up()<CR>"
lvim.keys.normal_mode["<C-l>"] = "<cmd>lua require('smart-splits').move_cursor_right()<CR>"
lvim.keys.normal_mode["<C-\\>"] = "<cmd>lua require('smart-splits').move_cursor_previous()<CR>"

-- Resize with Alt+hjkl (may require terminal support)
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { silent = true, desc = "Resize ←" })
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { silent = true, desc = "Resize ↓" })
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { silent = true, desc = "Resize ↑" })
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { silent = true, desc = "Resize →" })
vim.keymap.set("n", "<A-=>", "<C-w>=", { silent = true, desc = "Equalize splits" })

-- Swap buffers with Alt+Shift+hjkl
vim.keymap.set("n", "<A-H>", require("smart-splits").swap_buf_left, { silent = true, desc = "Swap buffer ←" })
vim.keymap.set("n", "<A-J>", require("smart-splits").swap_buf_down, { silent = true, desc = "Swap buffer ↓" })
vim.keymap.set("n", "<A-K>", require("smart-splits").swap_buf_up, { silent = true, desc = "Swap buffer ↑" })
vim.keymap.set("n", "<A-L>", require("smart-splits").swap_buf_right, { silent = true, desc = "Swap buffer →" })

-- which-key UI enabled
lvim.builtin.which_key.active = true

-- Register AFTER LVim defaults so ours win
lvim.builtin.which_key.on_config_done = function(wk)
	-- Top-level tweaks (valid top-level keys only)
	-- If you don't use famiu/bufdelete.nvim, change :Bdelete to :bd
	wk.register({
		c = { ":Bdelete<CR>", "Close Buffer" },
		C = { "<C-w>q<CR>", "Close Split" },
		n = { ":nohlsearch<CR>", "No Highlight" },
		h = { ":bp<CR>", "Prev Buffer" },
		l = { ":bn<CR>", "Next Buffer" },
		["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment" },
	}, { prefix = "<leader>" })

	-- LSP group
	wk.register({
		a = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings["a"] or { name = "+LSP" }, {
			d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", "Definition (Telescope)" },
			r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References (Telescope)" },
			i = { "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "Implementation (Telescope)" },
			t = { "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", "Type definitions (Telescope)" },
			D = { vim.lsp.buf.declaration, "Declaration" },
			h = { vim.lsp.buf.hover, "Hover" },
			R = { vim.lsp.buf.rename, "Rename" },
			a = { vim.lsp.buf.code_action, "Code action" },
			f = {
				function()
					vim.lsp.buf.format({ async = true })
				end,
				"Format buffer",
			},
			n = {
				function()
					vim.diagnostic.goto_next()
				end,
				"Next diagnostic",
			},
			p = {
				function()
					vim.diagnostic.goto_prev()
				end,
				"Prev diagnostic",
			},
			N = {
				function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Next ERROR",
			},
			P = {
				function()
					vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
				end,
				"Prev ERROR",
			},
		}),
	}, { prefix = "<leader>" })

	-- Search group
	local tb = require("telescope.builtin")

	-- helper: live_grep but include hidden files and ignore .git
	local function live_grep_hidden()
		tb.live_grep({
			additional_args = function()
				return { "--hidden", "--glob", "!.git" }
			end,
		})
	end

	-- helper: literal (non-regex) search
	local function live_grep_literal()
		tb.live_grep({
			additional_args = function()
				return { "--fixed-strings" }
			end,
		})
	end

	wk.register({
		s = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings["s"] or { name = "+Search" }, {
			f = { "<cmd>Telescope find_files<CR>", "Files" },
			b = { "<cmd>Telescope buffers<CR>", "Buffers" },
			r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
			t = {
				function()
					tb.live_grep()
				end,
				"Text (live grep)",
			},
			T = { live_grep_hidden, "Text incl. hidden" },
			w = {
				function()
					tb.grep_string()
				end,
				"Word under cursor",
			},
			L = { live_grep_literal, "Text (literal)" },
			s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search in buffer" },
			k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
			g = { "<cmd>Telescope git_files<CR>", "Git-tracked files" },
			d = { "<cmd>Telescope git_status<CR>", "Git dirty files" },
		}),
	}, { prefix = "<leader>" })

	local map = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
	end
	map("<leader>sg", tb.live_grep, "Search text (live_grep)")
	map("<leader>sG", live_grep_hidden, "Search text incl. hidden")
	map("<leader>sw", tb.grep_string, "Search word under cursor")
	map("<leader>sf", tb.current_buffer_fuzzy_find, "Fuzzy in buffer")

	-- Diagnostics submenu (Trouble)
	-- Requires: folke/trouble.nvim
	wk.register({
		x = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings["x"] or { name = "+Diagnostics" }, {
			x = { "<cmd>Trouble diagnostics toggle<CR>", "Diagnostics list" },
			q = { "<cmd>Trouble qflist toggle<CR>", "Quickfix list" },
		}),
	}, { prefix = "<leader>" })

	-- Display toggles
	wk.register({
		d = vim.tbl_deep_extend("force", lvim.builtin.which_key.mappings["d"] or { name = "+Display" }, {
			v = {
				function()
					local vt = vim.diagnostic.config().virtual_text
					vim.diagnostic.config({ virtual_text = not vt })
				end,
				"Toggle virtual text",
			},
		}),
	}, { prefix = "<leader>" })
end

-- Comment bindings (silent)
local ok_comment, api = pcall(require, "Comment.api")
if ok_comment then
	vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, { desc = "Comment: toggle line", silent = true })
	vim.keymap.set("v", "<leader>/", function()
		api.toggle.linewise(vim.fn.visualmode())
	end, { desc = "Comment: toggle selection", silent = true })
end

-- Snippet things. Im not sure if I want these:
local ls = require("luasnip")

-- Jump forward
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { expr = true, silent = true })

-- Jump backward
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	return ls.jumpable(-1) and "<Plug>luasnip-jump-prev" or "<S-Tab>"
end, { expr = true, silent = true })

-- Cycle choice nodes
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true, desc = "LuaSnip choice next" })
-- (Optional) Manual snippet folders
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" },
})
require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/lvim/snippets/my-snippets" } })
