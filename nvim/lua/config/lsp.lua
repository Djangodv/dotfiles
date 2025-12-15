-- Description

-- vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls' })

-- Works best with completeopt=noselect.
-- Don't pre-select menu items, use popup to display extra information and use the menu also when there is only one mathc
vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, {
				autotrigger = true,
				-- Add nerdfont glyphs and display detailed information in completion menu
				convert = function(item)
					local kind_icons = { '󰉿', '󰊕', '󰊕', '󰒓', '󰜢', '󰆦', '󰖷', '󱡠', '󱡠', '󱡠', '󰅩', '󰪚',
						'󰦨', '󰦨', '󰦨', '󰻾', '󰏿', '󱄽', '󰏘', '󰈔', '󰬲', '󰉋', '󱐋', '󰪚', '󰬛' }
					return { abbr = kind_icons[item.kind] .. "  " .. item.label }
				end,
			})
		end
		-- Formatting
		-- TODO: Add auto-formatting upon save
		if client:supports_method('textDocument/formatting') then
			vim.keymap.set('n', '<c-a>', function() vim.lsp.buf.format({
				formatting_options = {

					tabSize = 100,
					insertSpaces = false
					-- vim.lsp.FormattingOptions = { tabSize = 10 }
					-- lsp.FormattingOptions.tabSize = 10
				}
			}) end)
		end
	end,
})

-- Trigger autocompletion on every keypress. May be slow!
vim.api.nvim_create_autocmd("InsertCharPre", {
	callback = function()
		if not vim.api.nvim_get_current_line():sub(1, vim.api.nvim_win_get_cursor(0)[2]):match("^%s*$") then
			vim.lsp.completion.get()
			-- else
			--     print("Succes!")
		end
	end,
})

-- Use <cr> to confirm a completion
vim.keymap.set({ 'i' }, '<cr>', function()
	if vim.fn.pumvisible() == 1 then
		return '<c-y>'
	else
		return '<cr>'
	end
end, { desc = '...', expr = true })

-- Set max. items for completion menu
vim.opt.pumheight = 8

-- Enable diagnostics
vim.diagnostic.config({
	-- Use a curly line
	undercurl = true,
	-- Always show diagnostic info
	-- virtual_text = true,
	-- Show diagnostics info only when cursor in on the line
	virtual_text = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.WARN] = '',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.HINT] = ''
		},
	},
})

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#aa4844" })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f4be74" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#87875f" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#87875f" })

-- Make diagnostic sign colors match underline/foreground colors
vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#aa4844", bg = "#181818" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  { fg = "#f4be74", bg = "#181818" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  { fg = "#87875f", bg = "#181818" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint",  { fg = "#87875f", bg = "#181818" })

-- Undercurl colors
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#fb4934" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#fabd2f" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#83a598" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#b8bb26" })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#aa4844" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#f4be74" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#87875f" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#87875f" })
