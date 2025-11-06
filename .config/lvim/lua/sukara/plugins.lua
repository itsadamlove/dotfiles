lvim.plugins = {
	{ "rebelot/kanagawa.nvim" },
	-- Core LSP & tools (eager so command exist)
	{
		"williamboman/mason.nvim",
		lazy = false, -- ensure it loads immediately
		config = function()
			require("mason").setup() -- run setup at the right time
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vtsls",
					"eslint",
					"tailwindcss",
					"html",
					"cssls",
					"jsonls",
					"pyright",
					"ruff",
					"lua_ls",
					"bashls",
					"yamlls",
					"dockerls",
					"graphql",
					"prismals",
					"emmet_ls",
					"marksman",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		name = "none-ls.nvim",
		lazy = false,
		version = false, -- or pin a specific commit if you like
	},
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		dependencies = { "nvimtools/none-ls.nvim", "williamboman/mason.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = { "prettier", "eslint_d", "stylelint", "stylua", "ruff", "shfmt", "sql-formatter" },
				automatic_installation = true,
			})
		end,
	},

	-- Telescope faster sorter
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-ui-select.nvim" },

	-- Splits
	{ "mrjones2014/smart-splits.nvim" },

	-- QoL
	{ "numToStr/Comment.nvim" },
	{ "kylechui/nvim-surround" },
	{ "windwp/nvim-autopairs" },
	{ "lewis6991/gitsigns.nvim" },
	{ "moll/vim-bbye" },

	-- Diagnostics
	{ "folke/trouble.nvim", opts = {} },

	-- Indent guides
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Auto close tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
	},

	-- Notifications
	{ "rcarriga/nvim-notify" },

	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "saadparwaiz1/cmp_luasnip" },

	-- Pretty input fields
	{
		"folke/snacks.nvim",
		priority = 1000,
		opts = {
			-- enable only the bits you want
			input = { enabled = true }, -- replaces vim.ui.input
			select = { enabled = true }, -- replaces vim.ui.select
			-- everything else stays off by default
		},
	},

	{ "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	-- AI Things
	-- 	{
	-- 		"yetone/avante.nvim",
	-- 		-- build from source on Unix, or the provided PowerShell on Windows
	-- 		build = vim.fn.has("win32") ~= 0
	-- 				and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
	-- 			or "make",
	-- 		event = "VeryLazy",
	-- 		version = false, -- do NOT set to "*" (per docs)
	-- 		opts = {
	-- 			-- optional: a per-project instruction file (looked up from project root)
	-- 			instructions_file = "avante.md",

	-- 			-- choose which provider to use by name (must exist in `providers` below)
	-- 			provider = "claude",

	-- 			providers = {
	-- 				-- Anthropic (Claude)
	-- 				claude = {
	-- 					endpoint = "https://api.anthropic.com",
	-- 					model = "claude-sonnet-4-20250514",
	-- 					timeout = 30000, -- ms
	-- 					extra_request_body = {
	-- 						temperature = 0.75,
	-- 						max_tokens = 20480,
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		dependencies = {
	-- 			"nvim-lua/plenary.nvim",
	-- 			"MunifTanjim/nui.nvim",
	-- 			-- you already have telescope & snacks; list them only if you want Avante to use them for pickers/inputs:
	-- 			"nvim-telescope/telescope.nvim", -- file selector provider
	-- 			"folke/snacks.nvim", -- input provider
	-- 			"nvim-tree/nvim-web-devicons",

	-- 			-- Optional niceties:
	-- 			-- "ibhagwan/fzf-lua",                 -- alternative file picker
	-- 			-- "hrsh7th/nvim-cmp",                 -- completion for Avante commands/@mentions
	-- 			{
	-- 				"HakonHarnes/img-clip.nvim",
	-- 				event = "VeryLazy",
	-- 				opts = {
	-- 					default = {
	-- 						embed_image_as_base64 = false,
	-- 						prompt_for_file_name = false,
	-- 						drag_and_drop = { insert_mode = true },
	-- 						use_absolute_path = true, -- helpful on Windows
	-- 					},
	-- 				},
	-- 			},
	-- 			{
	-- 				"MeanderingProgrammer/render-markdown.nvim",
	-- 				opts = { file_types = { "markdown", "Avante" } },
	-- 				ft = { "markdown", "Avante" },
	-- 			},
	-- 		},
	-- 	},
}
-- Load snippets
require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({
	paths = { "~/.config/lvim/snippets" }, -- your old VSCode packs if you want
})

-- TODO:  do i need these?
pcall(function()
	require("Comment").setup()
end)
pcall(function()
	require("nvim-surround").setup()
end)
-- TODO: how does this play with leader slash?
pcall(function()
	require("nvim-autopairs").setup()
end)
