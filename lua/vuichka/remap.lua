vim.g.mapleader = " "
vim.g.localmapleader = " "

-- Centers while swiping page
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<C-e>', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Colemak NEIO navigation remaps with which-key descriptions

-- Basic navigation remaps
vim.keymap.set({ 'n', 'v' }, 'n', 'h', { desc = "Move left", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'e', 'j', { desc = "Move down", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'i', 'k', { desc = "Move up", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'o', 'l', { desc = "Move right", noremap = true })

-- Remap displaced keys
vim.keymap.set({ 'n', 'v' }, 'h', 'n', { desc = "Next search result", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'H', 'N', { desc = "Previous search result", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'j', 'e', { desc = "End of word", noremap = true })
vim.keymap.set({ 'n', 'v' }, 'J', 'E', { desc = "End of WORD", noremap = true })
vim.keymap.set('n', 'k', 'i', { desc = "Insert mode", noremap = true })
vim.keymap.set('n', 'K', 'I', { desc = "Insert at line start", noremap = true })
vim.keymap.set('n', 'l', 'o', { desc = "Open line below", noremap = true })
vim.keymap.set('n', 'L', 'O', { desc = "Open line above", noremap = true })

-- Windows remap for Colemak
--  See `:help wincmd` for a list of all window commands
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', { desc = 'window' })

-- Window mappings with descriptions for which-key
vim.keymap.set('n', '<leader>wn', '<C-W>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<leader>we', '<C-W>j', { desc = 'Go to window below' })
vim.keymap.set('n', '<leader>wi', '<C-W>k', { desc = 'Go to window above' })
vim.keymap.set('n', '<leader>wo', '<C-W>l', { desc = 'Go to right window' })
vim.keymap.set('n', '<leader>wp', '<C-W>p', { desc = 'Go to previous window' })
vim.keymap.set('n', '<leader>ww', '<C-W>w', { desc = 'Go to next window' })
vim.keymap.set('n', '<leader>wW', '<C-W>W', { desc = 'Go to previous window' })

vim.keymap.set('n', '<leader>ws', '<C-W>s', { desc = 'Split horizontally' })
vim.keymap.set('n', '<leader>wv', '<C-W>v', { desc = 'Split vertically' })
vim.keymap.set('n', '<leader>wq', '<C-W>q', { desc = 'Quit window' })
vim.keymap.set('n', '<leader>wc', '<C-W>c', { desc = 'Close window' })
vim.keymap.set('n', '<leader>wt', '<C-W>o', { desc = 'Only this window' })

vim.keymap.set('n', '<leader>w+', '<C-W>+', { desc = 'Increase height' })
vim.keymap.set('n', '<leader>w-', '<C-W>-', { desc = 'Decrease height' })
vim.keymap.set('n', '<leader>w<', '<C-W><', { desc = 'Decrease width' })
vim.keymap.set('n', '<leader>w>', '<C-W>>', { desc = 'Increase width' })
vim.keymap.set('n', '<leader>w=', '<C-W>=', { desc = 'Equal windows' })

vim.keymap.set('n', '<leader>wN', '<C-W>H', { desc = 'Move to far left' })
vim.keymap.set('n', '<leader>wE', '<C-W>J', { desc = 'Move to bottom' })
vim.keymap.set('n', '<leader>wI', '<C-W>K', { desc = 'Move to top' })
vim.keymap.set('n', '<leader>wO', '<C-W>L', { desc = 'Move to far right' })

vim.keymap.set('n', '<leader>wr', '<C-W>r', { desc = 'Rotate clockwise' })
vim.keymap.set('n', '<leader>wR', '<C-W>R', { desc = 'Rotate counter-clockwise' })
vim.keymap.set('n', '<leader>wx', '<C-W>x', { desc = 'Exchange windows' })
vim.keymap.set('n', '<leader>wT', '<C-W>T', { desc = 'Move to new tab' })
