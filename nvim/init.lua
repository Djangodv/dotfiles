-- Desc

-- Add snippets/after/ftplugin to path
vim.opt.rtp:append({'/home/user/.config/nvim/snippets/after'})

-- TODO: Test
-- Add snippets folder (after/ftplugin) to runtimepath to auto-load snippets
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/snippets")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place sjto setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('v', 's', '<nop>')
vim.g.maplocalleader = "s"

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.swapfile = false

vim.keymap.set('n', '<space>', ':')
vim.keymap.set('n', '<c-tab>', ':bn<cr>')

vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')

vim.keymap.set('n', '<c-space>', '<c-w>p')
vim.keymap.set('t', '<c-space>', '<c-\\><c-n><c-w>p')

vim.keymap.set('n', '<localleader>t', ':split term://bash<cr>A')

vim.keymap.set('n', '<localleader>s', ':w!<cr>')
vim.keymap.set('n', '<localleader>l', ':luafile ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<s-q>', ':wqall!<cr>')

vim.keymap.set('n', '<localleader>j', '<s-}>')



vim.pack.add({
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/kepano/flexoki-neovim',
	'https://github.com/nyoom-engineering/oxocarbon.nvim',
	'https://github.com/jacoborus/tender.vim',
	'https://github.com/bluz71/vim-moonfly-colors',
	'https://github.com/zenbones-theme/zenbones.nvim',
	'https://github.com/olimorris/onedarkpro.nvim',
	'https://github.com/savq/melange-nvim',
	'https://github.com/rmehri01/onenord.nvim',
	'https://github.com/navarasu/onedark.nvim',
	-- 'https://github.com/RRethy/base16-nvim',
	'https://github.com/chriskempson/base16-vim'

})

-- Fix error, regarding treesitter highlighting when opening a help file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	-- pattern = "*",
	callback = function()
		vim.treesitter.stop()
	end,
})

require('config.workspace')
require('config.fzf')
require('config.plugins')
require('config.snippets')
require('config.mappings')
require('config.options')
require('config.lsp')
