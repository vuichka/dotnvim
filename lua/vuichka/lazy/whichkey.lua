return {             -- Useful plugin to show you pending keybinds.
	'folke/which-key.nvim',
	event = 'VimEnter', -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		local wk = require('which-key')
		wk.setup()

		wk.add({
			{ "<leader>s ", group = '+telescope', mode = 'n' },
			{ '<leader>r',  group = '+lsp',       mode = 'n' },
			{ '<leader>h',  group = '+git',       mode = 'n' },
		})

		-- add which-key groups if you want organized help
		wk.add({
			{ "n", group = "Move left",   mode = "n" },
			{ "e", group = "Move down",   mode = "n" },
			{ "i", group = "Move up",     mode = "n" },
			{ "o", group = "Move right",  mode = "n" },
			{ "h", group = "Next search", mode = "n" },
			{ "j", group = "End of word", mode = "n" },
			{ "k", group = "Insert mode", mode = "n" },
			{ "l", group = "Open line",   mode = "n" },
		})

		-- Visual mode specific descriptions
		wk.add({
			{ "h", group = "Next search (visual)", mode = "v" },
			{ "j", group = "End of word (visual)", mode = "v" },
		})

		-- If you need to account for your Colemak remaps
		wk.add({
			{ "cs", group = "change surround", mode = "n" },
			{ "ds", group = "delete surround", mode = "n" },
			{ "ys", group = "add surround",    mode = "n" },
		})

		wk.add({
			{ "S", group = "surround", mode = "v" },
		})
	end,
}
