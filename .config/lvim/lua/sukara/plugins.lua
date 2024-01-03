-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{ "rebelot/kanagawa.nvim" },
	{ "wfxr/minimap.vim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "kazhala/close-buffers.nvim" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-fugitive" },
	-- Autoclose and autorename html tag
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{ "stephpy/vim-php-cs-fixer" },
	{ "prisma/vim-prisma" },
	-- Multi Cursors
	{ "mg979/vim-visual-multi" },
	-- Co Pilot
	{ "zbirenbaum/copilot.lua" },
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- Python Virtual Environment Switcher
	{ "AckslD/swenv.nvim" },
	{ "stevearc/dressing.nvim" },
	-- {
	--   "folke/trouble.nvim",
	--   cmd = "TroubleToggle",
	-- },
}

-- Load snippets
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" },
})
require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/lvim/snippets/my-snippets" } })
