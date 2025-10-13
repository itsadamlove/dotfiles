require("sukara.options")
require("sukara.plugins")

local ok_lsp, lspconfig = pcall(require, "lspconfig")
if not ok_lsp then
	vim.notify("nvim-lspconfig not found", vim.log.levels.ERROR)
	return
end

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

-- === TS/JS: vtsls silent actions on save (no popups) ===
local function collect_code_actions(bufnr, kinds, timeout)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = kinds, diagnostics = {} }
	local responses = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout or 800)
	local out = {}
	if not responses then
		return out
	end
	for _, resp in pairs(responses) do
		local res = resp.result
		if type(res) == "table" then
			for _, a in ipairs(res) do
				table.insert(out, a)
			end
		end
	end
	return out
end

local function apply_action(client, action)
	local function apply_edits(a)
		if a and a.edit then
			vim.lsp.util.apply_workspace_edit(a.edit, client.offset_encoding or "utf-16")
			return true
		end
		return false
	end
	if apply_edits(action) then
		return
	end
	if client.supports_method and client:supports_method("codeAction/resolve") then
		client.request("codeAction/resolve", action, function(_, resolved)
			if resolved then
				if apply_edits(resolved) then
					return
				end
				if resolved.command then
					vim.lsp.buf.execute_command(resolved.command)
				end
			end
		end)
		return
	end
	if action.command then
		vim.lsp.buf.execute_command(action.command)
	end
end

-- ask for both generic and .ts/.js variants
local ADD_MISSING = { "source.addMissingImports", "source.addMissingImports.ts", "source.addMissingImports.js" }
local REMOVE_UNUSED = { "source.removeUnused", "source.removeUnused.ts", "source.removeUnused.js" }
local ORGANIZE = { "source.organizeImports", "source.organizeImports.ts", "source.organizeImports.js" }

local function vtsls_actions_on_save(bufnr)
	local client = (vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" }) or {})[1]
	if not client then
		return
	end
	for _, kinds in ipairs({ ADD_MISSING, REMOVE_UNUSED, ORGANIZE }) do
		local acts = collect_code_actions(bufnr, kinds)
		if acts[1] then
			apply_action(client, acts[1])
		end
	end
end

local function enable_vtsls_actions_on_save(_, bufnr)
	local ft = vim.bo[bufnr].filetype
	if ft ~= "typescript" and ft ~= "typescriptreact" and ft ~= "javascript" and ft ~= "javascriptreact" then
		return
	end
	local grp = vim.api.nvim_create_augroup("TSJS.VTSLS.OnSave." .. bufnr, { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = grp,
		buffer = bufnr,
		callback = function()
			vtsls_actions_on_save(bufnr)
		end,
		desc = "TS/JS: vtsls add/remove/organize imports (silent)",
	})
end

lspconfig.vtsls.setup({
	on_attach = enable_vtsls_actions_on_save,
	settings = {
		typescript = {
			suggest = { autoImports = true },
			preferences = {
				includeCompletionsForModuleExports = true,
				includeCompletionsForImportStatements = true,
				importModuleSpecifierPreference = "non-relative",
				quoteStyle = "auto",
			},
			inlayHints = {
				enumMemberValues = true,
				functionLikeReturnTypes = true,
				parameterNames = { enabled = "literals" },
				parameterTypes = true,
				propertyDeclarationTypes = true,
				variableTypes = { enabled = true },
			},
		},
		javascript = {
			suggest = { autoImports = true },
			preferences = {
				includeCompletionsForModuleExports = true,
				includeCompletionsForImportStatements = true,
				quoteStyle = "auto",
			},
			inlayHints = { parameterTypes = true },
		},
	},
})

-- Optional: a manual test command you can run in a TS/JS buffer
vim.api.nvim_create_user_command("VtslsFixImports", function()
	vtsls_actions_on_save(0)
	vim.notify("vtsls: imports fixed (silent)")
end, {})

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
		ensure_installed = { "prettier", "stylelint", "stylua", "ruff", "shfmt", "sql-formatter" },
		automatic_installation = true,
	})

	null_ls.setup({
		sources = {
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
			local grp = vim.api.nvim_create_augroup("FormatOnSave." .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = grp,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						timeout_ms = 1500,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
				desc = "null-ls: Prettier before write",
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

lvim.builtin.treesitter.autotag = { enable = false }

require("sukara.eslint")
-- keymaps should be after plugins
require("sukara.keymaps")
