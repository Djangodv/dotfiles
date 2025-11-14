-- vim.opt.spell = true
vim.opt.spelllang = {'nl', 'en_gb'}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell"
})

-- vim.api.nvim_set_hl(0, 'LineNr', { bg = "#181818", fg = "#625e5a" })
-- vim.api.nvim_set_hl(0, 'SignColumn', { bg = "#181818" })
