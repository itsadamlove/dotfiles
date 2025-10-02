lvim.plugins = {
	{ "rebelot/kanagawa.nvim" },
	{ "wfxr/minimap.vim" },
  {"nvimtools/none-ls.nvm"},
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
	-- TODO:  SWAP TO FZF
	{ "nvim-telescope/telescope-fzy-native.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{ "prisma/vim-prisma" },
	-- Multi Cursors
	{ "mg979/vim-visual-multi" },
	-- Co Pilot
	-- { "zbirenbaum/copilot.lua" },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
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
	{ "stevearc/dressing.nvim" },
	{
		-- TODO: understand how to fix this
		"metakirby5/codi.vim",
		cmd = "Codi",
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				-- default_mappings = false, -- Bind default mappings
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
				-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
				-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
			})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			require("smart-splits").setup({
				at_edge = function(context)
					local dmap = {
						left = "west",
						down = "south",
						up = "north",
						right = "east",
					}
				end,
			})
		end,
	},
}

-- -- Load snippets
require("luasnip/loaders/from_vscode").load({
	paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" },
})
require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/lvim/snippets/my-snippets" } })
