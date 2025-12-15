-- Desc

-- .git/* matches only the directories and files inside .git/ not e.g. .git/src/file.py (non-recursive)
-- .git/** matches both
vim.opt.wildignore = { ".git/**", "**/build/**", "**/.cache/**", "**/venv/**", "**/managed_components/**" }
-- NOTE: Directories will be searched with '/*' after them, due to limitations of globpath()
vim.opt.path = { "/home/user/Github/", "/home/user/Github/dotfiles/", "/home/user/Github/dotfiles/nvim/", "/home/user/Github/dotfiles/nvim/lua/config", "/home/user/Github/dotfiles/nvim/snippets/after/ftplugin" }

local filescache = {}

function Find(args, cmdcomplete)

  if vim.tbl_isempty(filescache) then

    -- Wildignore is only applied when {nosuf} is false (very confusing docs)
    local cwd = vim.fn.getcwd()
    filescache = vim.fn.globpath('.', '**', false, true)

    -- Globpath expects a list of strings so the table returned by path has to be concentated
    local path = vim.opt.path:get()
    local str_path = table.concat(path, ',')
    local path_files = vim.fn.globpath(str_path, '*', true, true)

    for i = 1, #path_files do
      table.insert(filescache, path_files[i])
    end

    -- When you call a vim function from Lua, neovim automatically converts vimscript lists to Lua tables
    -- Set path relative to cwd (redundant in combination w. au for setting cwd)
    -- local filescache = vim.tbl_map(function(path) 
    --   return vim.fn.fnamemodify(path, ':.')
    -- end, filescache)
    
    -- print(vim.inspect(filescache))

  end
  return args == '' and filescache or vim.fn.matchfuzzy(filescache, args)
end

vim.opt.findfunc = 'v:lua.Find'

-- Empty cache file each time the workspace au sets the directory
vim.api.nvim_create_autocmd({'DirChanged', 'VimEnter'}, {
    pattern = "window",
    callback = function() 
      filescache = {} 
    end
  })
