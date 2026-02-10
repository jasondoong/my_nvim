vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
end, { desc = 'Open MiniFiles (current file dir)' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

-- quickfix
vim.keymap.set('n', '<leader>co', ':copen<CR>', { desc = 'open quickfix window' })
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', { desc = 'close quickfix window' })

-- copy the current buffer's file path to the clipboard
vim.keymap.set('n', '<leader>yf', function()
  -- Use the path relative to the current working directory instead of the
  -- absolute path. This keeps the copied path shorter when working inside a
  -- project directory.
  local path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  vim.fn.setreg('+', path)
  vim.notify('Copied path: ' .. path)
end, { desc = '[Y]ank current [F]ile path' })

vim.keymap.set('n', '<leader>ds', ':AerialNavToggle<CR>', { desc = 'toggle Aerial navigation' })

-- terminal
local split_term_buf
local split_term_win

local function toggle_horizontal_terminal()
  if split_term_win and vim.api.nvim_win_is_valid(split_term_win) then
    vim.api.nvim_win_close(split_term_win, true)
    split_term_win = nil
  elseif split_term_buf and vim.api.nvim_buf_is_valid(split_term_buf) then
    vim.cmd('botright split')
    split_term_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(split_term_win, split_term_buf)
  else
    vim.cmd('botright split')
    vim.cmd('terminal')
    split_term_win = vim.api.nvim_get_current_win()
    split_term_buf = vim.api.nvim_get_current_buf()
  end
end

vim.keymap.set('n', '<leader>h', toggle_horizontal_terminal, { desc = 'toggle horizontal terminal' })


-------------------------------------------------------------------------------
-- Pytest integration
-------------------------------------------------------------------------------
local pytest = require('my_pytest')
vim.keymap.set('n', '<leader>tt', pytest.run_nearest, { desc = 'Run nearest pytest in terminal' })
vim.keymap.set('n', '<leader>tf', pytest.run_file, { desc = 'run tests in the file' })
vim.keymap.set('n', '<leader>tl', pytest.run_last, { desc = 'run latest pytest again' })
vim.keymap.set('n', '<leader>to', pytest.toggle_terminal, { desc = 'toggle pytest output window' })
