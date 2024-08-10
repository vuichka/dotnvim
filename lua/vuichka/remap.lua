vim.g.mapleader = " "
vim.g.localmapleader = " "

local modes = { 'n', 'v' }

for _, mode in ipairs(modes) do
  vim.keymap.set(mode, 'h', 'n', { desc = 'goto_next' })
  vim.keymap.set(mode, 'j', 'o', { desc = 'insert left' })
  vim.keymap.set(mode, 'k', 'i', { desc = 'Go to end of the word' })
  vim.keymap.set(mode, 'l', 'e', { desc = 'insert next line' })

  vim.keymap.set(mode, 'n', 'h', { desc = 'left' })
  vim.keymap.set(mode, 'e', 'j', { desc = 'down' })
  vim.keymap.set(mode, 'i', 'k', { desc = 'up' })
  vim.keymap.set(mode, 'o', 'l', { desc = 'right' })
end

-- for _, mode in ipairs(modes) do
--   vim.keymap.set(mode, 'H', 'N', { desc = '' })
--   vim.keymap.set(mode, 'J', 'E', { desc = '' })
--   vim.keymap.set(mode, 'K', 'I', { desc = '' })
--   vim.keymap.set(mode, 'L', 'O', { desc = '' })
--
--   vim.keymap.set(mode, 'N', 'H', { desc = 'goto_prev' })
--   vim.keymap.set(mode, 'E', 'J', { desc = 'delete indent' })
--   vim.keymap.set(mode, 'I', 'K', { desc = 'lookup manual' })
--   vim.keymap.set(mode, 'O', 'L', { desc = 'insert next line' })
-- end

-- Centers while swiping page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
