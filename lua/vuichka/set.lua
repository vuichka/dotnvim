vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`

vim.opt.guicursor = ''
vim.opt.colorcolumn = '80'
vim.opt.textwidth = 80
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 50

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

vim.opt.fileformat = "unix"

vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'

vim.opt.hlsearch = false
vim.opt.incsearch = true
