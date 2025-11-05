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
    -- 'https://github.com/lukas-reineke/indent-blankline.nvim'
  })

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place sjto setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.keymap.set('n', 's', '<nop>')
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

vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')

vim.keymap.set('n', '<c-space>', '<c-w>p')
vim.keymap.set('t', '<c-space>', '<c-\\><c-n><c-w>p')

vim.keymap.set('n', '<localleader>j', ':split term://bash<cr>A')

vim.keymap.set('n', '<localleader>s', ':w!<cr>')
vim.keymap.set('n', '<localleader>l', ':luafile ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<s-q>', ':wqall!<cr>')

vim.cmd.colorscheme("alduin")

vim.lsp.enable({'clangd', 'pyright', 'lua_ls'})

-- Works best with completeopt=noselect.
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      vim.lsp.completion.enable(true, client.id, ev.buf, { 
          autotrigger = true,
          convert = function(item)
            local icons = {"1", '2', "2"}
            -- print(vim.inspect(item))
            return { abbr = icons[item.kind] }
        end,
      })
      -- vim.api.nvim_create_autocmd("InsertCharPre", {
      --         callback = function() vim.lsp.completion.get() end,
      --     })
    end
    if client:supports_method('textDocument/formatting') then
        vim.keymap.set('n', '<c-a>', function() vim.lsp.buf.format() end )
    end
  end,
})

-- {
--   additionalTextEdits = {},
--   data = {
--     autoImportText = "```\nfrom datetime import _Date\n```",
--     position = {
--       character = 2,
--       line = 4
--     },
--     symbolLabel = "_Date",
--     uri = "file:///home/user/lua-lsp-test/test.py"
--   },
--   detail = "Auto-import",
--   documentation = {
--     kind = "markdown",
--     value = "```\nfrom datetime import _Date\n```"
--   },
--   kind = 6,
--   label = "_Date",
--   labelDetails = {
--     description = "datetime"
--   },
--   sortText = "12.9999._Date.08.datetime",
--   textEdit = {
--     newText = "datetime._Date",
--     range = {
--       ["end"] = {
--         character = 2,
--         line = 4
--       },
--       start = {
--         character = 0,
--         line = 4
--       }
--     }
--   }
-- }

-- vim.api.nvim_create_autocmd("InsertCharPre", {
--         callback = function(char)
--             if char == "\t" then
--                 return ""
--             else
--                 vim.lsp.completion.get() 
--             end
--         end })

-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
    -- virtual_text = { current_line = true },
    undercurl = false,
    virtual_text = true,
    virtual_lines = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = ''
        },
        -- linehl = {
        --     [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        -- },
        -- numhl = {
        --     [vim.diagnostic.severity.WARN] = 'WarningMsg',
        -- },

    },
})

-- Enable diagnostics
-- vim.diagnostic.config({ virtual_text = { current_line = true } })
-- vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#aa4844" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f4be74" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#689eb4" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#689eb4" })

-- Gruvbox-inspired undercurl for LSP diagnostics
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#fb4934" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#fabd2f" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#83a598" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#b8bb26" })

local ls = require('luasnip')

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "/home/user/.local/share/nvim/site/pack/core/opt/friendly-snippets/snippets" } })
require("luasnip.loaders.from_vscode").lazy_load()

 
 --    {
 --      callback = function() vim.lsp.completion.get() end,
 --  })
vim.api.nvim_create_autocmd("InsertCharPre", {
        callback = function()
            if not vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2]):match("^%s*$") then
                vim.lsp.completion.get()
            else
                print("Succes!")
            end
        end,
    })

vim.keymap.set('i', '<tab>', function()
    if vim.fn.pumvisible() == 1 then
        return "<c-n>"
    else
        return "<tab>"
    end
end, {expr = true} )


-- Map different key to c-n

-- vim.keymap.set('i', '<tab>', function()
--     if vim.fn.pumvisible() == 1 then
--         return "<c-n>"
--     else
--         return "<tab>"
--     end
-- end, {expr = true} )

-- local function completion()
--     if vim.fn(pumvisible()) then
--         return "Hello"
--     else
--         return "False"
--     end
-- end

-- vim.keymap.set('i', '<tab>', completion())


-- function! CleverTab()
--    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
--       return "\<Tab>"
--    else
--       return "\<C-N>"
--    endif
-- endfunction
-- inoremap <Tab> <C-R>=CleverTab()<CR>

-- complete_add({expr})                                            complete_add()

-- 		Add {expr} to the list of matches.  Only to be used by the
-- 		function specified with the 'completefunc' option.
-- 		Returns 0 for failure (empty string or out of memory),
-- 		1 when the match was added, 2 when the match was already in
-- 		the list.
-- 		See complete-functions for an explanation of {expr}.  It is
-- 		the same as one item in the list that 'omnifunc' would return.
