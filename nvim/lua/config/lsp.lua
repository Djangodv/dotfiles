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
			vim.keymap.set('n', '<c-a>', function() vim.lsp.buf.format() end)
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

-- Jump snippets with <tab>
-- Select mode 's' is a mode used often by snippet plugins, include vim.snippet
vim.keymap.set({ 'i', 's' }, '<tab>', function()
	if vim.snippet.active({ direction = 1 }) then
		return '<cmd>lua vim.snippet.jump(1)<cr>'
	elseif vim.fn.pumvisible() == 1 then
		-- Can't find the right func for calling selecting next completion, but c-n can still be remapped in normal mode
		-- Alternatively return a <down>?
		return "<c-n>"
	else
		return "<tab>"
	end
end, { desc = '...', expr = true })

-- Expand custom snippets with <space>
-- SOURCE: https://boltless.me/posts/neovim-config-without-plugins-2025/
function vim.snippet.add(trigger, body, opts)
	vim.keymap.set("ia", trigger, function()
		-- If abbrev is expanded with keys like "(", ")", "<cr>", "<space>",
		-- don't expand the snippet. Only accept "<c-]>" as a trigger key.
		local c = vim.fn.nr2char(vim.fn.getchar(0))
		-- if c ~= "" and c ~= "\r" then
		-- 32 is the ASCII Code for <space>
		if c ~= "" and vim.fn.char2nr(c) ~= 32 then
			vim.api.nvim_feedkeys(trigger .. c, "i", true)
			return
		end
		vim.snippet.expand(body)
	end, opts)
end

vim.snippet.add(
	"fn",
	"function ${1:name}($2)\n\t${3:-- content}\nend",
	{ buffer = 0 }
)
vim.snippet.add(
	"lfn",
	"local function ${1:name}($2)\n\t${3:-- content}\nend",
	{ buffer = 0 }
)


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
	virtual_text = true,
	-- Show diagnostics info only when cursor in on the line
	-- virtual_text = { current_line = true },
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

-- Undercurl colors
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#fb4934" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#fabd2f" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#83a598" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#b8bb26" })
