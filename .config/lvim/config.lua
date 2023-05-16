-- TODO
-- Somethings still arent working
-- 1. Formatting on save (prettier in js files)
-- 2. Snippets in react (typing p tags is a nightmare)
-- 3. The filedraw on start up is horrible
-- 4. Code actions take a really long time
-- 5. PHP CS Fixer is still a nightmare and not working
-- 6. OrganiseImports is not bound - need to figure this out
-- 7. Maybe I want to re-enable the warnings inline because the gutter warnings might not be enough
-- 8. Bufferbar styling
-- 9. Tmux line styling
-- 10. Fuzzy search within project
-- 11. React specific linting - highlighting useCallback Errors
-- 12. Debugging
-- 13. Co pilot

--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
--------
-------- Vim Options
--------
require("sukara.options")
require("sukara.keymaps")
require("sukara.plugins")

-- Icons
-- lvim.use_icons = true

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- -- Change theme settings
lvim.colorscheme = "kanagawa"

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
-- lvim.builtin.nvimtree.setup.view.number = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.format_on_save.enabled = true

vim.diagnostic.config({ virtual_text = false })

lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "fzy_native")
	pcall(telescope.load_extension, "ui-select")
end

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "black" },
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-width", "120" },
		-- filetypes = {
		-- 	"typescript",
		-- 	"typescriptreact",
		-- 	"typescript.tsx",
		-- 	"javascript",
		-- 	"javascriptreact",
		-- 	"javascript.jsx",
		-- },
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "flake8", filetypes = { "python" } },
	-- TODO: check speed when using spell check
	-- {
	-- 	command = "shellcheck",
	-- 	args = { "--severity", "warning" },
	-- },
})
local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		exe = "eslint",
		-- filetypes = { "typescript", "typescriptreact" },
	},
})

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- require("null-ls").setup({
-- 	-- you can reuse a shared lspconfig on_attach callback here
-- 	on_attach = function(client, bufnr)
-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				buffer = bufnr,
-- 				callback = function()
-- 					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
-- 					-- vim.lsp.buf.formatting_sync()
-- 					vim.lsp.buf.format({ bufnr = bufnr })
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })
