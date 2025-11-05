-- Quickfixlist function for opening a buffer

-- Create and customize output in quickfixlist (used by buffersqflist)
local function createqflist(qftitle, itemslist)
  vim.fn.setqflist({}, 'r', {title = qftitle, items = itemslist, quickfixtextfunc = function(info) 
      local _items = vim.fn.getqflist({id = 0, items = 1}).items
      print(vim.inspect(_items))
      local l = {}
      for item in pairs(_items) do
        print(vim.inspect(item))
        table.insert(l, vim.fn.fnamemodify(vim.fn.bufname(_items[item].bufnr), ':p:.'))
      end

      return l
    end
    })
end

-- Custom quickfixlist function for displaying all open buffers
local function bufferqflist()

  local active_buffers = vim.api.nvim_list_bufs()
  local qfitems = {}

  for buffer in ipairs(active_buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) and vim.api.nvim_buf_get_option(buffer, 'filetype') ~= 'qf' then
      qfitem = {
        filename = vim.api.nvim_buf_get_name(buffer),
        text = vim.api.nvim_buf_get_name(buffer)
      }
      table.insert(qfitems, qfitem)
    end
  end

  createqflist("Buffers", qfitems)

  vim.cmd('copen')

end

vim.api.nvim_create_user_command('BufferQflist', function() bufferqflist() end, {})
vim.keymap.set('n', '<Plug>BufferQflist', function() buffersqflist() end)
