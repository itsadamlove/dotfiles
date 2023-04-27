local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "nvim-tree/nvim-tree.lua",
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    run = ":TSUpdate",
  },
  { "tpope/vim-fugitive" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  { "tpope/vim-endwise" },
  { "kazhala/close-buffers.nvim" },
  { "eandrju/cellular-automaton.nvim" },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  -- Anything above here is setup
  "nvim-tree/nvim-web-devicons",
  "folke/neodev.nvim",
  "nvim-lualine/lualine.nvim",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      {
        -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },               -- Required
      {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = {
          { "rafamadriz/friendly-snippets" },
          {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
          },
        },
      },                   -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
      -- Additional
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "f3fora/cmp-spell" },
      { "hrsh7th/cmp-cmdline" },
      { "tamago324/cmp-zsh" },
      --    {'SirVer/ultisnips'},
      --    {'honza/vim-snippets'},
      --    {'quangnguyen30192/cmp-nvim-ultisnips'},
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
  },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "MunifTanjim/prettier.nvim" },
  { "ckipp01/stylua-nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  "NvChad/nvim-colorizer.lua",
  "rafamadriz/neon",
  "lewis6991/gitsigns.nvim",
  "sindrets/diffview.nvim",
  "windwp/nvim-ts-autotag",
  "lukas-reineke/indent-blankline.nvim",
  "prisma/vim-prisma",
  "jiangmiao/auto-pairs",
  -- Comment
  "terrortylor/nvim-comment",
  -- Multi Cursors
  "mg979/vim-visual-multi",
  -- ColorSchemes
  { "savq/melange-nvim" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    config = function()
      -- vim.cmd('colorscheme rose-pine')
    end,
  },
  { "rebelot/kanagawa.nvim", priority = 1000, lazy = false },
  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    priority = 1000,
    lazy = false,
  },
})
