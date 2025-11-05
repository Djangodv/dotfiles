-- NOTE: The fuzzy find function below used for the :find command won't correctly ignore starstar patterns with numbers, like .git/**2
-- NOTE: Also doesn't support dir/*/otherdir
-- Wildignore: only **/dir/**, or */dir/*

-- https://www.gammon.com.au/scripts/doc.php?lua=string.find
-- .git/* matches only the directories and files inside .git/ not e.g. .git/src/file.py (non-recursive)
-- .git/** matches both

-- In lua ^abc says match anything except a, b, c
-- [] is a character class, [abc] matches any single character within the brackets and returns the first match
-- [abc]* in banana returns b, a, a, a
-- [^/]* so this tells lua to match any character as long as its not a /, if so stop and return the preceding matches?

-- vim.opt.wildignore = {"dir2/*",".git/*", "*/build/*", "*/.cache/*", "*/venv/*", "*/src/*", "**/venv/**"}
-- vim.opt.path:append({ "**/main/**", "docs/**" })

-- Functions that use global variables cannot be reused easily, without significant chance of interference

local uv = vim.uv

local function scandir_sync(dir)

  local files = {}
  local handle = uv.fs_scandir(dir)

  -- if not ignorelist[dir] then
  --   print(dir)
  -- end
  -- print(vim.inspect(ignorelist))

  if not handle then return files end

  while true do
    local name, _type = uv.fs_scandir_next(handle)
    if not name then break end
    local path = dir .. '/' .. name
    -- print(vim.inspect(path))
    if _type == 'directory' then
      local subfiles = scandir_sync(path)
      for i = 1, #subfiles do
        files[#files + 1] = subfiles[i]
      end
    end
    files[#files +1] = path
    -- table.insert(files, path)
  end

  return files
end


-- local dir_prefix = dir
-- if not dir:match("/$") then
--     dir_prefix = dir .. "/"
-- end

-- then inside loop
-- local path = dir_prefix .. name

-- local files = scandir_sync('/home/user/testdir')
-- print(vim.inspect(files))

local filescache = {}

function Find(args, cmdcomplete)

    -- local wildignore = vim.opt.wildignore:get()
    -- local luaignore = {}
    -- for i = 1, #wildignore do 
    --   wildignore[i] = wildignore[i]:gsub("%*%*", ".*"):gsub("%*", "[^/]*")
    --   luaignore[wildignore[i]] = true
    -- end

    -- local dir = "/testdir/dir2/files"

    -- if ignorelist[dir] then
    --   print(dir)
    -- end
    -- print(vim.inspect(ignorelist))

  if vim.tbl_isempty(filescache) then

    -- print(vim.inspect(wildignore))
    -- print(vim.inspect(luaignore))

    -- Wildignore is only applied when {nosuf} is false (very confusing docs)
    filescache = vim.fn.globpath('.', '**', false, true)
    -- local cwd = vim.fn.getcwd()
    -- filescache = scandir_sync(cwd)
    -- print(vim.inspect(filescache))
    -- When you call a vim function from Lua, neovim automatically convers vimscripts lists to Lua tables
    -- Might be redundant
    -- local filtered = vim.tbl_filter(function(path) 
    --   return vim.uv.fs_stat(path).type ~= 'directory'
        -- Adds nil checking for e.g. symlinks
    --   local stat = uv.fs_stat(path)
    --   return stat and stat.type ~= 'directory'
    -- end, filescache )
    -- local filescache = vim.tbl_map(function(path) 
    --   return vim.fn.fnamemodify(path, ':.')
    -- end, filescache)
    -- print(vim.inspect(files))
  end
  if args == '' then
    -- print(vim.inspect(filescache))
    return filescache
  else
    -- print(vim.inspect(filescache))
    return vim.fn.matchfuzzy(filescache, args)
  end
  -- return args == '' and filescache or vim.fn.matchfuzzy(filescache, args)
end

vim.opt.findfunc = 'v:lua.Find'

vim.api.nvim_create_autocmd('CmdlineEnter', {
    pattern = {":"},
    callback = function() filescache = {} end
  })

-- set findfunc=Find
-- func Find(arg, _)
--   if empty(s:filescache)
--     let s:filescache = globpath('.', '**', 1, 1)
--     call filter(s:filescache, '!isdirectory(v:val)')
--     call map(s:filescache, "fnamemodify(v:val, ':.')")
--   endif
--   return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
-- endfunc
-- let s:filescache = []
-- autocmd CmdlineEnter : let s:filescache = []

-- vim.opt.wildignore = {"dir2/*",".git/*", "*/build/*", "*/.cache/*", "*/venv/*", "*/src/*", "**/venv/**"}

local wildignore = vim.opt.wildignore:get()
local luaignore = {}
for i = 1, #wildignore do 
  wildignore[i] = wildignore[i]:gsub("%*%*", ".*"):gsub("^%*", "[^/]*"):gsub("%*$", "[^/]*")
  -- luaignore[wildignore[i]] = true
end

local dir = "dir2/files"

if luaignore[dir] then
  print(dir)
end
print(vim.inspect(wildignore))
    
-- .*
-- ^%*
    local cwd = vim.fn.getcwd()
    filescache = scandir_sync(cwd)
