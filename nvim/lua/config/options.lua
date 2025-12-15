vim.opt.spelllang = {'nl', 'en_gb'}

-- Autocommand for enabling spellling correction in .md files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell"
})

-- vim.api.nvim_set_hl(0, 'LineNr', { bg = "#181818", fg = "#625e5a" })
-- vim.api.nvim_set_hl(0, 'SignColumn', { bg = "#181818" })

-- Fix indentation (equal to LSP auto-format)
-- vim.opt.expandtab = false -- or:
-- vim.opt.tabstop?
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- Ignore capital letters when searching
vim.opt.ignorecase = true

-- Show cursorline
vim.opt.cursorline = true

-- Show linenumbers
vim.opt.number = true

-- Disable swapfiles
vim.opt.swapfile = false
