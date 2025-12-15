-- Desc

-- Add snippets folder (/snippets/after) to runtimepath to auto-load snippets
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/snippets/after")

-- Load Lua config files
require('config.mappings')
require('config.options')
require('config.workspace')
require('config.fzf')
require('config.plugins')
require('config.snippets')
require('config.lsp')

-- Fix error, regarding treesitter highlighting when opening a help file
vim.api.nvim_create_autocmd("FileType", {
	-- pattern = {"help"},
	pattern = "*",
	callback = function()
		vim.treesitter.stop()
	end,
})

