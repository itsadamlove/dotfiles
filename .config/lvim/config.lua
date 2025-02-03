--------
-------- Vim Options
--------
require("sukara.options")
require("sukara.plugins")

-- Icons
-- lvim.use_icons = true

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

lvim.builtin.telescope.defaults = {
	-- prompt_prefix = "🔍 ",
	file_ignore_patterns = { "node_modules", ".git", ".cache", "Pods", "ios-sourcemap.json" },
	layout_config = {
		horizontal = { preview_width = 0.6 },
	},
}

-- TOOD: might want the other version
lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "fzy_native")
	pcall(telescope.load_extension, "ui-select")
end

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	-- "python",
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

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/languages#lintingformatting>

-- Skip pylyzer setup in favour of Ruff
lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.skip_setup = { "pylyzer" }
lvim.lsp.installer.setup.ensure_installed = { "pyright", "ruff_lsp" }

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- { name = "black" },
	{ name = "ruff" },
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
	{ name = "eslint_d" },
	{ name = "stylelint" },
	{ name = "ruff", filetypes = { "python" } },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "eslint_d",
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	},
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

lspconfig.pyright.setup({
	settings = {
		pyright = {
			-- Using Ruff's import organiser
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				-- Ignore all files for analysis to exclusively use Ruff for linting
				ignore = { "*" },
			},
		},
	},
})

lspconfig.ruff_lsp.setup({
	on_attach = function(client, bufnr)
		-- Enable formatting on save if the server supports it
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
	init_options = {
		-- Enable “organize imports” + “fix all” on save:
		organizeImports = true,
		fixAll = true,
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
