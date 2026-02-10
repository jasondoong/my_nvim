local M = {
  dependencies = {
    'nvim-treesitter.ts_utils',
  },
}

-- Terminal buffer used for running pytest
local pytest_buf
-- The window that currently displays `pytest_buf`
local pytest_win
-- Track the last pytest command so it can be re-run
local last_pytest_cmd = 'pytest'

-- Send a command to the pytest terminal. If the terminal does not exist,
-- it will be created. The last command is stored so that it can be
-- executed again later.
local function send_to_terminal(cmd)
  last_pytest_cmd = cmd

  if not pytest_buf or not vim.api.nvim_buf_is_valid(pytest_buf) then
    vim.cmd('botright split')
    vim.cmd('terminal')
    pytest_win = vim.api.nvim_get_current_win()
    pytest_buf = vim.api.nvim_get_current_buf()
  elseif not pytest_win or not vim.api.nvim_win_is_valid(pytest_win) then
    vim.cmd('botright split')
    pytest_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(pytest_win, pytest_buf)
  end

  local current = vim.api.nvim_get_current_win()

  local ok, job_id = pcall(vim.api.nvim_buf_get_var, pytest_buf, 'terminal_job_id')
  if ok then
    vim.api.nvim_chan_send(job_id, cmd .. '\n')
  else
    vim.api.nvim_win_call(pytest_win, function()
      vim.fn.feedkeys(cmd .. '\n')
    end)
  end

  vim.api.nvim_set_current_win(current)
end

function M.toggle_terminal()
  if pytest_win and vim.api.nvim_win_is_valid(pytest_win) then
    vim.api.nvim_win_close(pytest_win, true)
    pytest_win = nil
  elseif pytest_buf and vim.api.nvim_buf_is_valid(pytest_buf) then
    vim.cmd('botright split')
    pytest_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(pytest_win, pytest_buf)
  else
    send_to_terminal(last_pytest_cmd)
  end
end

function M.run_last()
  send_to_terminal(last_pytest_cmd)
end

function M.run_nearest()
  local bufnr = 0
  local path = vim.fn.expand('%:p')

  local parser = vim.treesitter.get_parser(bufnr, 'python')
  parser:parse()

  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()

  local func_name
  local class_name

  while node do
    local type = node:type()
    if not func_name and type == 'function_definition' then
      local name = node:field('name')[1]
      func_name = vim.treesitter.get_node_text(name, bufnr)
    elseif type == 'class_definition' then
      local name = node:field('name')[1]
      class_name = vim.treesitter.get_node_text(name, bufnr)
      break
    end
    node = node:parent()
  end

  local nodeid
  if func_name then
    if class_name then
      nodeid = string.format('%s::%s::%s', path, class_name, func_name)
    else
      nodeid = string.format('%s::%s', path, func_name)
    end
  elseif class_name then
    nodeid = string.format('%s::%s', path, class_name)
  else
    nodeid = path
  end

  send_to_terminal(('pytest %s'):format(nodeid))
end

function M.run_file()
  local file = vim.fn.expand('%:p')
  send_to_terminal('pytest ' .. vim.fn.fnameescape(file))
end

return M
