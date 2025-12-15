-- Desc

-- Map leader keys
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('v', 's', '<nop>')
vim.g.mapleader = "\\"
vim.g.maplocalleader = "s"

-- Filename completion
vim.keymap.set('i', '<c-f>', '<c-x><c-f>')

-- Jump to document under cursor
vim.keymap.set('n', '<cr>', '<cmd>lua vim.lsp.buf.definition()<cr>')

-- Auto-correct spelling mistake
-- Source: https://castel.dev/post/lecture-notes-1/
vim.keymap.set('i', '<c-s>', '<c-g>u<esc>[s1z=`]a<c-g>u')

-- vim.keymap.set('n', '<m-l>', '%')
-- vim.keymap.set('n', '<localleader>k', '%')

-- Install 'xclip' with: sudo apt install xclip
-- Paste/copy keybindings (c-v, c-c)
vim.keymap.set('v', '<c-c>', '"+y')
vim.keymap.set({'n', 'i'}, '<c-v>', '<esc>"+p')

-- Bind command line
vim.keymap.set({'n', 'v'}, '<space>', ':')

-- TODO: Implement functionality for detecting already... 
-- Previous tab
vim.keymap.set('n', '<c-tab>', '<c-^>')

-- Switch window
vim.keymap.set('n', '<c-space>', '<c-w>p')

-- Save
vim.keymap.set('n', '<localleader>s', ':w!<cr>')
-- Source config
vim.keymap.set('n', '<localleader>l', ':luafile ~/.config/nvim/init.lua<cr>')
-- Save quit all
vim.keymap.set('n', '<s-q>', ':wqall!<cr>')

-- Terminal mode mappings
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')
vim.keymap.set('t', '<c-space>', '<c-\\><c-n><c-w>p')

vim.keymap.set('n', '<localleader>t', ':split term://bash<cr>A')

-- Netrw
vim.keymap.set('n', '-', ':Explore<cr>')
