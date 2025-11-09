-- vim.opt.spell = true
vim.opt.spelllang = {'nl', 'en_gb'}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell"
})

