vim.pack.add({
    { src = "https://github.com/L3MON4D3/LuaSnip", version = 'v2.4.0' },
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/Saghen/blink.cmp", version = 'v1.7.0'},
    -- "https://github.com/Saghen/blink.cmp",
    "https://github.com/nvim-lua/plenary.nvim",
    -- { src = "https://github.com/nvim-telescope/telescope.nvim", ver = 'v0.1.8'},
    'https://github.com/AlessandroYorba/Alduin',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    -- 'https://github.com/gruvbox-community/gruvbox',
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/WTFox/jellybeans.nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/catppuccin/nvim',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/lukas-reineke/indent-blankline.nvim'
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

vim.keymap.set('n', '<localleader>s', ':luafile ~/.config/nvim/init.lua<cr>')

vim.cmd.colorscheme("alduin")


-- Lua configuration to silence errors in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("setlocal nonumber")  -- Hide line numbers
    -- Optional: mute error messages in terminal mode
    vim.opt.shortmess:append("F")  -- Suppress file messages
  end,
})

local function define_run_keybind(filetype, keybinding, command)
  vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function()
        vim.keymap.set('n', keybinding, command)
        -- vim.keymap.set('n', keybinding, command, {buffer = true})
      end,
    })
end

define_run_keybind("python", "<localleader>r", ':!python3 %<cr>')

local ls = require("luasnip")

vim.keymap.set("i", "<CR>", function()
  if ls.expandable() then
    vim.schedule(function() ls.expand() end)
  else
    return "\n"
  end
end, { expr = true, silent = true })

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- Setup additional language servers with: https://github.com/neovim/nvim-lspconfig
vim.lsp.enable({'clangd', 'pyright'})
p>echo glob('.vimrc')

-- Enable diagnostics
-- vim.diagnostic.config({ virtual_text = { current_line = true } })
vim.diagnostic.config({ virtual_text = true })

require("luasnip.loaders.from_vscode").lazy_load()


require("blink.cmp").setup({

keymap = {
  ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
  ["<S-Tab>"] = { "select_prev","snippet_backward", "fallback" },
},

completion = {

  -- accept = { auto_brackets = { enabled = true}, },

  -- Select first item with <tab>
  list = { max_items = 8, selection = { preselect = false } },

  -- Show snippet indicator
  menu = { draw = { snippet_indicator = '~' } },

  -- Show documentation when selecting a completion item
  documentation = { auto_show = true, auto_show_delay_ms = 0 },

},

-- Configure LuaSnip for snippet soure
snippets = { preset = 'luasnip' },
cmdline = { enabled = false },

-- Experimental feature showing automatic documentation
signature = { enabled = true },

-- Suppress warning about Rust fuzzy search
fuzzy = { implementation = "lua" },

})

require'nvim-treesitter.configs'.setup {
highlight = {

  -- Enable treesitter
  enable = false,

  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,
},
}

local function git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  if string.len(branch) > 0 then
      return branch
  else
      return ": "
  end
end

local function mode()
local map = {
  n = " NOR ",
    i = " INS ",
    v = " VIS ",
    V = " VIS "
  }
  -- :h mode() for when adding more modes
  return vim.fn.get(map, vim.fn.mode(), '')
end

function status_line()
  return string.format(
      "%s 󱗽",
      mode()
    )
end
 
-- v:lua.function() is a prefix used to call global (only) Lua functions from Vimscript
vim.opt.statusline = "%!v:lua.status_line()"
-- vim.opt.statusline = "%!v:lua.mode() .. '%m '"
-- "%!v:lua.mode()" .. "%F " .. "%m " .. git_branch() .. "%S" .. "%=" .. "%y " .. "%p" .. "%S"

-- vim.opt.statusline = string.gsub(vim.opt.statusline, "%s", git_branch(), 1)

-- Enable spell check
-- vim.opt.spell = true
-- vim.opt.spelllang = { "en_us" }

vim.opt.showmode = false
vim.opt.showcmd = false
