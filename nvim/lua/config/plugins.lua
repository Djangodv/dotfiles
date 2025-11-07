-- Desc

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
  })

-- Required setup
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
      "clangd"
    }
  })
