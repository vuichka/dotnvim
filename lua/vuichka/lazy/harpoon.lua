return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
	config = function()
		local harpoon = require 'harpoon'

		harpoon:setup()

		vim.keymap.set('n', '<leader>a', function()
			harpoon:list():add()
		end, { desc = "Harpoon [a]dd" })
		vim.keymap.set('n', '<leader>l', function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon [l]ist" })

		vim.keymap.set('n', '<leader>n', function()
			harpoon:list():select(1)
		end, { desc = "Harpoon 1" })
		vim.keymap.set('n', '<leader>e', function()
			harpoon:list():select(2)
		end, { desc = "Harpoon 2" })
		vim.keymap.set('n', '<leader>i', function()
			harpoon:list():select(3)
		end, { desc = "Harpoon 3" })
		vim.keymap.set('n', '<leader>o', function()
			harpoon:list():select(4)
		end, { desc = "Harpoon 4" })

		vim.keymap.set('n', '<leader>rn', function()
			harpoon:list():replace_at(1)
		end, { desc = "Harpoon [r]eplace 1" })
		vim.keymap.set('n', '<leader>re', function()
			harpoon:list():replace_at(2)
		end, { desc = "Harpoon [r]eplace 2" })
		vim.keymap.set('n', '<leader>ri', function()
			harpoon:list():replace_at(3)
		end, { desc = "Harpoon [r]eplace 3" })
		vim.keymap.set('n', '<leader>ro', function()
			harpoon:list():replace_at(4)
		end, { desc = "Harpoon [r]eplace 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set('n', '<leader>H', function()
		-- 	harpoon:list():prev()
		-- end, { desc = "Harpoon previous" })
		-- vim.keymap.set('n', '<leader>h', function()
		-- 	harpoon:list():next()
		-- end, { desc = "Harpoon Next" })
	end,
}
