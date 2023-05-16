-- If php-cs-fixer is in $PATH, you don't need to define line below
-- let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar

-- If you use php-cs-fixer version 1.x
vim.g.php_cs_fixer_level = "symfony" -- options: --level (default:symfony)
vim.g.php_cs_fixer_config = "default" -- options: --config
-- If you want to define specific fixers:
-- vim.g.php_cs_fixer_fixers_list = "linefeed,short_tag" " options: --fixers
-- vim.g.php_cs_fixer_config_file = '.php_cs'            " options: --config-file
-- End of php-cs-fixer version 1 config params

-- If you use php-cs-fixer version 2.x
vim.g.php_cs_fixer_rules = "@PSR2" -- options: --rules (default:@PSR2)
-- vim.g.php_cs_fixer_cache = ".php_cs.cache" -- options: --cache-file
-- vim.g.php_cs_fixer_config_file = '.php_cs' -- options: --config
vim.g.php_cs_fixer_allow_risky = "yes" -- options: --allow-risky
-- End of php-cs-fixer version 2 config params

vim.g.php_cs_fixer_php_path = "php" -- Path to PHP
vim.g.php_cs_fixer_enable_default_mapping = 1 -- Enable the mapping by default (<leader>pcd)
vim.g.php_cs_fixer_dry_run = 0 -- Call command with dry-run option
vim.g.php_cs_fixer_verbose = 0 -- Return the output of command if 1, else an inline information.
-- vim.g.php_cs_fixer_ignore_env = 1              -- Ignoring any environment requirements

-- TODO: figure this out:
-- autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
--
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.php" },
	command = "silent! call PhpCsFixerFixFile()",
})
