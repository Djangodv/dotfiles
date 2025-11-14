vim.keymap.set('i', '<c-f>', '<c-x><c-f>')
vim.keymap.set('n', '<cr>', '<cmd>lua vim.lsp.buf.definition()<cr>')

-- https://castel.dev/post/lecture-notes-1/
vim.keymap.set('i', '<c-s>', '<c-g>u<esc>[s1z=`]a<c-g>u')

vim.keymap.set('n', '<m-l>', '%')
vim.keymap.set('n', '<localleader>k', '%')
