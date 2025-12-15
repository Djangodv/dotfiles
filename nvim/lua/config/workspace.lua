-- Desc

-- Autocompletion for commandline and searches
vim.api.nvim_create_autocmd("CmdlineChanged", {
        pattern = {':', '/', '?'},
        callback = function()
            -- print(vim.inspect(vim.fn.getcmdline()))
            vim.fn.wildtrigger()
        end,
})

-- Set wildmode and wildoptions
vim.opt.wildmode = { "noselect", "full" }
vim.opt.wildoptions = { "fuzzy" }

-- Auto change directory to a folder that either contains a .git or else project files defined by the lsp config 
vim.api.nvim_create_autocmd({'BufEnter', 'LspAttach'}, {
  callback = function()

    -- Check for help files
    local buffer = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_option(buffer, 'filetype') == 'help' or 'cmd' then
      -- Return skips the rest of the function
      return
    end

    local clients = vim.lsp.get_clients({ bufnr = 0 })
    local file_dir = vim.fn.expand("%:p:h")
    local result = vim.system({'git', 'rev-parse', '--show-toplevel'}, { text = true, cwd = file_dir }):wait()
    local git_root = result.stdout:gsub("\n", "")
    local cwd = vim.fn.getcwd(0)
  
    -- Schedules {fn} to be invoked soon by the main event-loop. 
    -- Makes the change in cwd detectable by other autocommand, e.g. DirChanged to empty filescache
    vim.schedule(function() 
      if git_root ~= "" and git_root ~= cwd then
          vim.cmd("silent! lcd " .. git_root)
      elseif clients ~= nil and #clients > 0 then
          local lsp_root = clients[1].config.root_dir
          if lsp_root and lsp_root ~= cwd then
            vim.cmd("silent! lcd " .. lsp_root)
          end
      elseif file_dir ~= cwd then
          vim.cmd("silent! lcd " .. file_dir)
      end
    end )

  end })

-- TODO: update with a CursorIdle event
-- TODO: update to exclude `RO` buffers
-- Lua configuration for autosave
vim.api.nvim_create_autocmd({"FocusLost", "BufLeave"}, {
  callback = function(args)
    local buf = vim.api.nvim_get_current_buf()
    
    -- Check if the buffer has a name (is not empty)
    if vim.api.nvim_buf_get_name(buf) ~= "" then
      vim.cmd("silent! w")  -- Save the buffer
      -- vim.cmd("w")  -- Returns error when inside a help page, i.e. RO
      -- print(vim.inspect(args.buf))
    end
  end,
})

-- Netrw
vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    callback = function() 
      -- 'remap' are recursive mappings, off by default (default: noremap = true)
      vim.keymap.set('n', '<c-n>', '%', { buffer = true, remap = true })
      vim.keymap.set('n', 'r', 'R', { buffer = true, remap = true })
      vim.keymap.set('n', '-', ':bd<cr>', { buffer = true, remap = true })
    end
  })
