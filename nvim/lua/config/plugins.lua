-- Desc

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    -- run: :call mkdp#util#install() after installation to complete setup
    "https://github.com/iamcco/markdown-preview.nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/rebelot/kanagawa.nvim"

  })

-- Required setup
require("bufferline").setup{}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "clangd",
      "marksman"
    }
  })

-- Indent lines
require("ibl").setup({
  scope = {enabled = false},
  indent = { char = '▏' },
})

require("kanagawa").setup({
    colors = {
        palette = {
            oldWhite = "#c5c9c5", -- your new color here
	    dragonBlack4 = "#181818",
        },
    },
})

vim.cmd.colorscheme("kanagawa-dragon")
