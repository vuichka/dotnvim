return {
	vim.api.nvim_create_user_command('Ohtml', function()
		vim.system({ "open", "-e", vim.api.nvim_buf_get_name(0) })
	end, { desc = 'Output to html for printing' })
}
