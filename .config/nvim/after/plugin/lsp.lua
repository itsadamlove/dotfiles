local lsp = require("lsp-zero").preset({})
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
require("luasnip/loaders/from_vscode").lazy_load()

lsp.on_attach(function(_, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, {})
	-- MORE
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = true })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

vim.cmd([[
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
]])

lsp.setup()

-- cmp.setup(
-- {
--   sources = {
--     {name = 'path'},
--     {name = 'nvim_lsp'},
--     {name = 'buffer', keyword_length = 3},
--     {name = 'luasnip', keyword_length = 2},
--   },
--   mapping = {
--     -- `Enter` key to confirm completion
--     ['<CR>'] = cmp.mapping.confirm({select = false}),

--     -- Ctrl+Space to trigger completion menu
--     ['<C-Space>'] = cmp.mapping.complete(),

--     -- Navigate between snippet placeholder
--     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--     ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--   }
-- })

local kind_icons = {
	Class = "ﴯ",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "",
	Interface = "",
	Keyword = "",
	Method = "",
	Module = "",
	Operator = "",
	Property = "ﰠ",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip`, uncomment the following.
			-- vim.fn["vsnip#anonymous"](args.body)
			-- For `luasnip`, uncomment the following.
			require("luasnip").lsp_expand(args.body)
			-- For snippy, uncomment the following.
			-- require('snippy').expand_snippet(args.body)
			-- For `ultisnips`
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				spell = "[Spellings]",
				zsh = "[Zsh]",
				buffer = "[Buffer]",
				ultisnips = "[Snip]",
				treesitter = "[Treesitter]",
				calc = "[Calculator]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				nvim_lsp_signature_help = "[Signature]",
				cmdline = "[Vim Command]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-M-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-M-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
	completion = {},
	matching = {
		disallow_fuzzy_matching = false,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- For ultisnips users
		-- { name = 'ultisnips' },
		-- For vsnip users, uncomment the following.
		-- { name = 'vsnip' },
		-- For luasnip users, uncomment the following.
		{ name = "luasnip" },
		-- For snippy users, uncomment the following.
		-- { name = 'snippy' },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "nvim_lsp_signature_help" },
	}, {
		{ name = "path" },
	}),
})

-- Diagnostics
vim.api.nvim_set_keymap(
	"n",
	"<leader>do",
	"<cmd>lua vim.diagnostic.open_float()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
