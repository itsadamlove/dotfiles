--------
-------- Vim Options
--------
require("sukara.options")
require("sukara.plugins")

-- Icons
-- lvim.use_icons = true

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- -- Change theme settings
lvim.colorscheme = "kanagawa"
-- lvim.colorscheme = "kanagawa-lotus"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup.filters.dotfiles = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.renderer.icons.show.folder = true
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.project.manual_mode = true

vim.diagnostic.config({ virtual_text = false })

lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "fzy_native")
	pcall(telescope.load_extension, "ui-select")
end

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
-- lvim.builtin.treesitter.ignore_install = { "haskell" }
-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"comment",
	"markdown_inline",
	"regex",
	"prisma",
}

lvim.builtin.nvimtree.setup.filters.custom = { "node_modules", "\\.cache", "Pods", "ios-sourcemap.json" }

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "black" },
	{ name = "stylua" },
	{
		name = "prettier",
		extra_args = { "--print-width", "120" },
	},
	{ name = "stylelint" },
	{ name = "sql_formatter" },
	{ name = "phpcsfixer" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ name = "flake8", filetypes = { "python" }, extra_args = { "--max-line-length", "120" } },
	{ name = "eslint_d" },
	{ name = "stylelint" },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		-- 	name = "eslint",
		name = "eslint_d",
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	},
	-- { name = "phpcs" },
})

local lspconfig = require("lspconfig")
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
	-- on_attach = on_attach,
	-- capabilities = capabilities,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

-- Require snippets
require("luasnip/loaders/from_vscode").load({
	paths = {
		"~/.config/lvim/snippets/vscode-es7-javascript-react-snippets",
		"~/.config/lvim/snippets/my-snippets",
	},
})

lvim.format_on_save.enabled = true

-- Note: Keymaps should come after plugins so that our custom mapping applies
require("sukara.keymaps")
