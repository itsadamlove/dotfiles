require("sukara.options")
require("sukara.plugins")

local lspconfig = require("lspconfig")
lvim.lsp.null_ls.setup = { on_setup = function() end } -- no-op to stop the built-in

lvim.colorscheme = "kanagawa"

-- Tree file management
lvim.builtin.nvimtree.active = true
lvim.builtin.nvimtree.setup = vim.tbl_deep_extend("force", lvim.builtin.nvimtree.setup or {}, {
	filters = { dotfiles = true },
	renderer = { icons = { show = { git = true, folder = true } }, group_empty = true },
	respect_buf_cwd = true,
	sync_root_with_cwd = true,
	update_focused_file = { enable = true },
})

-- treesitter - installing and removing tree sitter parsers
-- The parser that understands the code structure, powers syntax highlighting and auto tag
-- Manage parsers per language. :TSUpdate, :checkhealth
lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"markdown",
	"markdown_inline",
	"regex",
	"prisma",
}
lvim.builtin.treesitter.highlight.enable = true

-- lspconfig
-- Attaches LSP servers to neovim
-- Enables def/impl/refs/hover, completion, diagnostics, organise imports

-- TypeScript / JavaScript
lspconfig.vtsls.setup({
	settings = {
		typescript = {
			inlayHints = {
				enumMemberValues = true,
				functionLikeReturnTypes = true,
				parameterNames = { enabled = "literals" },
				parameterTypes = true,
				propertyDeclarationTypes = true,
				variableTypes = { enabled = true },
			},
			preferences = { includeCompletionsForModuleExports = true },
		},
		javascript = { inlayHints = { parameterTypes = true } },
	},
})

-- Python: keep Pyright for type intelligence, disable its diagnostics;
-- let Ruff (via ruff_lsp + none-ls) do lint/fix/format/imports.
lspconfig.pyright.setup({
	settings = {
		pyright = { disableOrganizeImports = true }, -- Ruff handles imports
		python = { analysis = { diagnosticMode = "off" } }, -- no diagnostics from Pyright
	},
})

lspconfig.ruff.setup({
	init_options = {
		organizeImports = true,
		fixAll = true,
	},
	-- no special on_attach needed unless you add keymaps
})

-- Tell lua LSP that vim is a global
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "lvim" }, -- tell LuaLS these are valid globals
			},
			workspace = {
				checkThirdParty = false, -- don’t prompt for 3rd-party/unknown libs
			},
			telemetry = { enable = false },
			format = { enable = false }, -- keep false; stylua will format
		},
	},
})

-- Telescope extras
lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "fzf")
	pcall(telescope.load_extension, "ui-select")
end

lvim.builtin.telescope.defaults = vim.tbl_deep_extend("force", lvim.builtin.telescope.defaults or {}, {
	-- Make ripgrep the engine for live_grep with sensible flags
	vimgrep_arguments = {
		"rg",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
		-- If you want hidden files globally for live_grep, uncomment:
		-- "--hidden", "--glob", "!.git",
	},
	file_ignore_patterns = { "node_modules", ".git/", ".cache", "Pods", "ios-sourcemap.json" },
	layout_config = { horizontal = { preview_width = 0.6 } },
})

-- ── none-ls (formatters/linters/code actions)
local ok_null, null_ls = pcall(require, "null-ls")
if ok_null then
	local fmt = null_ls.builtins.formatting
	local diag = null_ls.builtins.diagnostics
	local acts = null_ls.builtins.code_actions

	require("mason-null-ls").setup({
		ensure_installed = { "prettier", "eslint_d", "stylelint", "stylua", "ruff", "shfmt", "sql-formatter" },
		automatic_installation = true,
	})

	null_ls.setup({
		sources = {
			-- JS/TS
			diag.eslint_d.with({
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
			}),
			acts.eslint_d.with({
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" },
			}),
			fmt.prettier.with({
				extra_args = { "--print-width", "120" },
				filetypes = {
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"svelte",
					"json",
					"jsonc",
					"css",
					"scss",
					"less",
					"html",
					"markdown",
					"markdown.mdx",
					"yaml",
					"graphql",
					"handlebars",
				},
			}),
			-- CSS
			diag.stylelint,
			fmt.stylelint,
			-- Lua
			fmt.stylua,
			-- Python
			fmt.ruff.with({ filetypes = { "python" } }),
			-- Shell / SQL
			fmt.shfmt.with({ filetypes = { "sh", "bash", "zsh" } }),
			fmt.sql_formatter.with({ filetypes = { "sql" } }),
		},
		on_attach = function(client, bufnr)
			-- “ESLint fix” → then format (prefer null-ls) on save
			local grp = vim.api.nvim_create_augroup("FmtFix." .. bufnr, {})
			vim.api.nvim_clear_autocmds({ group = grp, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = grp,
				buffer = bufnr,
				callback = function()
					-- try ESLint fix-all if available
					local supports = client.supports_method and client:supports_method("textDocument/codeAction")
					if supports then
						vim.lsp.buf.code_action({
							context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
							apply = true,
						})
					end
					-- then format (prefer null-ls)
					vim.lsp.buf.format({
						bufnr = bufnr,
						timeout_ms = 1000,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
			})
		end,
	})
end

-- set notify as the default notifier (after plugins load)
local ok, notify = pcall(require, "notify")
if ok then
	vim.notify = notify
	notify.setup({ stages = "fade_in_slide_out" }) -- tweak if you like
end

-- Snippet & CMP
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- enable snippets
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- keymaps should be after plugins
require("sukara.keymaps")
