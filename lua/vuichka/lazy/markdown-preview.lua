function OpenMarkdownPreview(url)
	vim.cmd('open ' .. url)
end

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_theme = 'dark'
		vim.g.mkdp_browser = 'chromium'
		vim.g.mkdp_port = '9099'
	end,
	ft = { "markdown" },

}
