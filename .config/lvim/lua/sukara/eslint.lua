-- lua/sukara/eslint.lua
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local function exists(p)
	return p and vim.uv.fs_stat(p) ~= nil
end
local function join(...)
	return vim.fs.joinpath(...)
end

-- Find a root that actually has an ESLint config (flat or legacy)
local function find_eslint_root(startpath)
	return util.search_ancestors(startpath, function(dir)
		-- Flat config?
		for _, f in ipairs({ "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" }) do
			if exists(join(dir, f)) then
				return dir
			end
		end
		-- Legacy?
		for _, f in ipairs({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			".eslintrc.yaml",
			".eslintrc.yml",
		}) do
			if exists(join(dir, f)) then
				return dir
			end
		end
		-- package.json with "eslintConfig"
		local pkg = join(dir, "package.json")
		if exists(pkg) then
			local ok, lines = pcall(vim.fn.readfile, pkg)
			if ok and lines then
				local ok2, obj = pcall(vim.json.decode, table.concat(lines, "\n"))
				if ok2 and type(obj) == "table" and obj.eslintConfig ~= nil then
					return dir
				end
			end
		end
	end)
end

local function has_flat_config(root)
	for _, f in ipairs({ "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts" }) do
		if exists(join(root, f)) then
			return true
		end
	end
	return false
end

lspconfig.eslint.setup({
	single_file_support = false,
	root_dir = function(fname)
		return find_eslint_root(fname) -- return nil => don’t attach (expected for non-ESLint projects)
	end,
	on_new_config = function(cfg, root)
		cfg.settings = cfg.settings or {}
		cfg.settings.workingDirectory = { mode = "location" } -- great for subfolders/monorepos
		cfg.settings.experimental = { useFlatConfig = has_flat_config(root) }
		cfg.settings.format = false -- leave formatting to Prettier/null-ls
	end,
	on_attach = function(_, bufnr)
		-- Optional: fix all on save
		local g = vim.api.nvim_create_augroup("ESLintFix." .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = g,
			buffer = bufnr,
			command = "EslintFixAll",
			desc = "ESLint: fix all",
		})
	end,
})
