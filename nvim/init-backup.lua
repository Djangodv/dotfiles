vim.pack.add({
    { src = "https://github.com/L3MON4D3/LuaSnip", version = 'v2.4.0' },
    "https://github.com/rafamadriz/friendly-snippets",
    -- { src = "https://github.com/Saghen/blink.cmp", version = 'v1.7.0'},
    -- "https://github.com/Saghen/blink.cmp",
    -- "https://github.com/nvim-lua/plenary.nvim",
    -- { src = "https://github.com/nvim-telescope/telescope.nvim", ver = 'v0.1.8'},
    -- 'https://github.com/AlessandroYorba/Alduin',
    -- 'https://github.com/nvim-treesitter/nvim-treesitter',
    -- 'https://github.com/gruvbox-community/gruvbox',
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/WTFox/jellybeans.nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/catppuccin/nvim',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/navarasu/onedark.nvim',
    -- 'https://github.com/lukas-reineke/indent-blankline.nvim'
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/junegunn/fzf',
    'https://github.com/junegunn/fzf.vim'
  })

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

vim.keymap.set('n', '<localleader>j', ':split term://bash<cr>A')

vim.keymap.set('n', '<localleader>s', ':w!<cr>')
vim.keymap.set('n', '<localleader>l', ':luafile ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<s-q>', ':wqall!<cr>')

vim.opt.termguicolors = true
require("bufferline").setup{}

-- Set up a key mapping for FZF with 'ls' as the source
-- vim.keymap.set('n', '<localleader>fn', function() 
--     vim.fn['fzf#run'](vim.fn['fzf#wrap']({ 
--         -- source = 'ls',
--         dir = vim.fn.stdpath("config"),
--         sink = 'e',
--       }))
-- end, { silent = true })

-- " - Popup window (anchored to the bottom of the current window)
-- vim.g.fzf_layout = { window = { width = 0.9, height = 0.2 } }

vim.g.fzf_action = {
    ["ctrl-t"] = "tab split",
    ["ctrl-x"] = "split",
    ["ctrl-v"] = "vsplit",
    ["ctrl-o"] = "!open",
    ["esc"] = "q"
}

vim.keymap.set('n', '<localleader>fb', ':Buffers<cr>') -- Buffers
vim.keymap.set('n', '<localleader>fr', ':Rg<cr>') -- Buffers
vim.keymap.set('n', '<localleader>fc', ':Files<cr>') -- Buffers
vim.keymap.set('n', '<localleader>fw', ':Files<cr>') -- Buffers
vim.keymap.set('n', '<localleader>fd', ':DFiles<cr>') -- Buffers

-- vim.keymap.set('n', '<leader>ff', function()
--   local opts = vim.empty_dict()
--   opts.source = 'ls ~'
--   opts.options = '--bind esc:abort --preview "cat {}" --prompt "Files> "'
--   opts.sink = 'e'
--   local spec = vim.call('fzf#wrap', 'my_fzf', opts)
--   vim.call('fzf#run', spec)
-- end, { silent = true })

-- -- function! FzfSearchDirectories(dir)
-- --   call 
-- -- endfunction

-- -- nnoremap <silent> <localleader>g :call FzfSearchDirectories('~/')<cr>

-- -- command! -bang -nargs=? -complete=dir Files
-- --     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)

-- The 'opts' is a lua table that contains all the command metadata
vim.api.nvim_create_user_command('DFiles', function(opts)
  -- opts.args contains what the user typed as an argument after the command
  -- opts.bang is true if :Files! was used
  vim.call('fzf#vim#files', opts.args, {
    options = {'--layout=reverse', '--info=inline', '--preview', 'cat {}'}
    -- else/if: 1 if :Files! was used
  }, opts.bang and 1 or 0)
end, {
  bang = true,
  nargs = '?',
  complete = 'dir',
})

local function append()
  vim.call('fzf#run', { 
      -- sink = "'<,'>w >> ",
      sink = function(selected)
        -- :normal! doesn't take into account user mappings
        -- vim.cmd("normal! \"Vy")
        -- new = string.format("'<,'>normal! | e %s", selected, selected)
        -- new = string.format("e %s", selected)
        -- print(vim.fn.getreg('v'))
        -- vim.cmd(new)
        -- vim.cmd(string.format("'<,'>w >> %s \\| e %s", selected, selected))

        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>'")
        local lines = vim.fn.getline(start_line, end_line)

        print(vim.inspect(lines))

        table.insert(lines, 1, "")
        new = table.concat(lines, "\n")

        local file = io.open(selected, 'a')
        file:write(new)
        file:close()
        vim.cmd("e " .. selected)

      end,
      -- dir = '~/Github'
  })
end

vim.keymap.set('v', '<localleader>a', function() append() end)
vim.keymap.set('n', '<localleader>a', function() append() end)

vim.keymap.set('v', '<leader>a', function()
  -- Yank the selected text into register a (append)
  vim.cmd("normal! \"Ay")
  -- Optionally, show the contents of register 'a' after appending
  print("Register 'a' now contains: " .. vim.fn.getreg('a'))
end)

-- fb: buffers down - list
-- fr: ripgrep full - preview
-- fc: config full - preview
-- fw: wiki full - preview
-- sfd: files


-- sfe: explorer
-- sff
-- Append selection to filek

-- Using vim.tbl_map to square each number in a list
-- local numbers = {1, 2, 3, 4}
-- local squares = vim.tbl_map(function(val)
--   return val * val
-- end, numbers)

-- print(vim.inspect(squares))  -- Output: {1, 4, 9, 16}

-- print(vim.inspect(vim.api.nvim_list_bufs()))

