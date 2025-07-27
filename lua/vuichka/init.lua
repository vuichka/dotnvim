require 'vuichka.set'
require 'vuichka.remap'
require 'vuichka.lazy_init'
require 'vuichka.after.colemak'


-- -- [[ Basic Autocommands ]]
-- --  See `:help lua-guide-autocommands`

-- -- Highlight when yanking (copying) text
-- --  Try it with `yap` in normal mode
-- --  See `:help vim.highlight.on_yank()`

local augroup = vim.api.nvim_create_augroup
local vuichkagroup = augroup('vuichka', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
	require('plenary.reload').reload_module(name)
end

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank {
			higroup = 'IncSearch',
			timeout = 40,
		}
	end,
})

autocmd({ 'BufWritePre' }, {
	group = vuichkagroup,
	pattern = '*',
	command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
	group = vuichkagroup,
	callback = function(e)
		vim.keymap.set('n', 'gd', function()
			vim.lsp.buf.definition()
		end, { buffer = e.buf, desc = 'Goto Defenition' })

		vim.keymap.set('n', 'M', function()
			vim.lsp.buf.hover()
		end, { buffer = e.buf, desc = 'hover' })

		vim.keymap.set('n', '<leader>ra', function()
			vim.lsp.buf.code_action()
		end, { buffer = e.buf, desc = 'code action' })

		vim.keymap.set('n', '<leader>rn', function()
			vim.lsp.buf.rename()
		end, { buffer = e.buf, desc = 'rename' })

		vim.keymap.set('i', '<C-h>', function()
			vim.lsp.buf.signature_help()
		end, { buffer = e.buf })

		vim.keymap.set('n', '[d', function()
			vim.diagnostic.goto_prev()
		end, { buffer = e.buf, desc = 'go to next diagnostic' })

		vim.keymap.set('n', ']d', function()
			vim.diagnostic.goto_next()
		end, { buffer = e.buf, desc = 'go to prev diagnostic' })
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
