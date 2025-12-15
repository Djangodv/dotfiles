-- Desc

-- Jump snippets with <tab>
-- Select mode 's' is a mode used often by snippet plugins, include vim.snippet
vim.keymap.set({'i', 's'}, '<tab>', function()
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

