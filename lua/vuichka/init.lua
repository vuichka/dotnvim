require 'vuichka.set'
require 'vuichka.remap'
require 'vuichka.lazy_init'

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
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = vuichkagroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = vuichkagroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- -- [[ Configure and install plugins ]]
-- --
-- --  To check the current status of your plugins, run
-- --    :Lazy
-- --
-- --  You can press `?` in this menu for help. Use `:q` to close the window
-- --
-- --  To update plugins you can run
-- --    :Lazy update
-- --
-- -- NOTE: Here is where you install your plugins.
-- require('lazy').setup({
--   -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
--   'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

--   -- NOTE: Plugins can also be added by using a table,
--   -- with the first argument being the link and the following
--   -- keys can be used to configure plugin behavior/loading/etc.
--   --
--   -- Use `opts = {}` to force a plugin to be loaded.
--   --
--   --  This is equivalent to:
--   --    require('Comment').setup({})

--   -- "gc" to comment visual regions/lines
--   { 'numToStr/Comment.nvim', opts = {} },

--   -- Here is a more advanced example where we pass configuration
--   -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--   --    require('gitsigns').setup({ ... })
--   --
--   -- See `:help gitsigns` to understand what the configuration keys do
--   { -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       signs = {
--         add = { text = '+' },
--         change = { text = '~' },
--         delete = { text = '_' },
--         topdelete = { text = '‾' },
--         changedelete = { text = '~' },
--       },
--     },
--   },

--   -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--   --
--   -- This is often very useful to both group configuration, as well as handle
--   -- lazy loading plugins that don't need to be loaded immediately at startup.
--   --
--   -- For example, in the following configuration, we use:
--   --  event = 'VimEnter'
--   --
--   -- which loads which-key before all the UI elements are loaded. Events can be
--   -- normal autocommands events (`:help autocmd-events`).
--   --
--   -- Then, because we use the `config` key, the configuration only runs
--   -- after the plugin has been loaded:
--   --  config = function() ... end

--   { -- Autoformat
--     'stevearc/conform.nvim',
--     lazy = false,
--     keys = {
--       {
--         '<leader>f',
--         function()
--           require('conform').format { async = true, lsp_fallback = true }
--         end,
--         mode = '',
--         desc = '[F]ormat buffer',
--       },
--     },
--     opts = {
--       notify_on_error = false,
--       format_on_save = function(bufnr)
--         -- Disable "format_on_save lsp_fallback" for languages that don't
--         -- have a well standardized coding style. You can add additional
--         -- languages here or re-enable it for the disabled ones.
--         local disable_filetypes = { c = true, cpp = true }
--         return {
--           timeout_ms = 500,
--           lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
--         }
--       end,
--       formatters_by_ft = {
--         lua = { 'stylua' },
--         go = { 'gofumpt' },
--         -- Conform can also run multiple formatters sequentially
--         -- python = { "isort", "black" },
--         --
--         -- You can use a sub-list to tell conform to run *until* a formatter
--         -- is found.
--         -- javascript = { { "prettierd", "prettier" } },
--       },
--     },
--   },

--   { -- Autocompletion
--     'hrsh7th/nvim-cmp',
--     event = 'InsertEnter',
--     dependencies = {
--       -- Snippet Engine & its associated nvim-cmp source
--       {
--         'L3MON4D3/LuaSnip',
--         build = (function()
--           -- Build Step is needed for regex support in snippets.
--           -- This step is not supported in many windows environments.
--           -- Remove the below condition to re-enable on windows.
--           if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--             return
--           end
--           return 'make install_jsregexp'
--         end)(),
--         dependencies = {
--           -- `friendly-snippets` contains a variety of premade snippets.
--           --    See the README about individual language/framework/plugin snippets:
--           --    https://github.com/rafamadriz/friendly-snippets
--           -- {
--           --   'rafamadriz/friendly-snippets',
--           --   config = function()
--           --     require('luasnip.loaders.from_vscode').lazy_load()
--           --   end,
--           -- },
--         },
--       },
--       'saadparwaiz1/cmp_luasnip',

--       -- Adds other completion capabilities.
--       --  nvim-cmp does not ship with all sources by default. They are split
--       --  into multiple repos for maintenance purposes.
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-path',
--     },
--     config = function()
--       -- See `:help cmp`
--       local cmp = require 'cmp'
--       local luasnip = require 'luasnip'
--       luasnip.config.setup {}

--       cmp.setup {
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--         completion = { completeopt = 'menu,menuone,noinsert' },

--         -- For an understanding of why these mappings were
--         -- chosen, you will need to read `:help ins-completion`
--         --
--         -- No, but seriously. Please read `:help ins-completion`, it is really good!
--         mapping = cmp.mapping.preset.insert {
--           -- Select the [n]ext item
--           ['<C-n>'] = cmp.mapping.select_next_item(),
--           -- Select the [p]revious item
--           ['<C-p>'] = cmp.mapping.select_prev_item(),

--           -- Scroll the documentation window [b]ack / [f]orward
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),

--           -- Accept ([y]es) the completion.
--           --  This will auto-import if your LSP supports it.
--           --  This will expand snippets if the LSP sent a snippet.
--           ['<C-y>'] = cmp.mapping.confirm { select = true },

--           -- If you prefer more traditional completion keymaps,
--           -- you can uncomment the following lines
--           --['<CR>'] = cmp.mapping.confirm { select = true },
--           --['<Tab>'] = cmp.mapping.select_next_item(),
--           --['<S-Tab>'] = cmp.mapping.select_prev_item(),

--           -- Manually trigger a completion from nvim-cmp.
--           --  Generally you don't need this, because nvim-cmp will display
--           --  completions whenever it has completion options available.
--           ['<C-Space>'] = cmp.mapping.complete {},

--           -- Think of <c-l> as moving to the right of your snippet expansion.
--           --  So if you have a snippet that's like:
--           --  function $name($args)
--           --    $body
--           --  end
--           --
--           -- <c-l> will move you to the right of each of the expansion locations.
--           -- <c-h> is similar, except moving you backwards.
--           ['<C-l>'] = cmp.mapping(function()
--             if luasnip.expand_or_locally_jumpable() then
--               luasnip.expand_or_jump()
--             end
--           end, { 'i', 's' }),
--           ['<C-h>'] = cmp.mapping(function()
--             if luasnip.locally_jumpable(-1) then
--               luasnip.jump(-1)
--             end
--           end, { 'i', 's' }),

--           -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--           --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--         },
--         sources = {
--           { name = 'nvim_lsp' },
--           { name = 'luasnip' },
--           { name = 'path' },
--         },
--       }
--     end,
--   },

--   -- { -- You can easily change to a different colorscheme.
--   --   -- Change the name of the colorscheme plugin below, and then
--   --   -- change the command in the config to whatever the name of that colorscheme is.
--   --   --
--   --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--   --   'folke/tokyonight.nvim',
--   --   priority = 1000, -- Make sure to load this before all the other start plugins.
--   --   init = function()
--   --     -- Load the colorscheme here.
--   --     -- Like many other themes, this one has different styles, and you could load
--   --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'. or night
--   --     vim.cmd.colorscheme 'tokyonight-storm'
--   --
--   --     -- You can configure highlights by doing something like:
--   --     vim.cmd.hi 'Comment gui=none'
--   --   end,
--   -- },



--    -- Highlight todo, notes, etc in comments
--   { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },

--   { -- Collection of various small independent plugins/modules
--     'echasnovski/mini.nvim',
--     config = function()
--       -- Better Around/Inside textobjects
--       --
--       -- Examples:
--       --  - va)  - [V]isually select [A]round [)]paren
--       --  - yinq - [Y]ank [I]nside [N]ext [']quote
--       --  - ci'  - [C]hange [I]nside [']quote
--       require('mini.ai').setup { n_lines = 500 }

--       -- Add/delete/replace surroundings (brackets, quotes, etc.)
--       --
--       -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--       -- - sd'   - [S]urround [D]elete [']quotes
--       -- - sr)'  - [S]urround [R]eplace [)] [']
--       require('mini.surround').setup()

--       -- Simple and easy statusline.
--       --  You could remove this setup call if you don't like it,
--       --  and try some other statusline plugin
--       local statusline = require 'mini.statusline'
--       -- set use_icons to true if you have a Nerd Font
--       statusline.setup { use_icons = vim.g.have_nerd_font }

--       -- You can configure sections in the statusline by overriding their
--       -- default behavior. For example, here we set the section for
--       -- cursor location to LINE:COLUMN
--       ---@diagnostic disable-next-line: duplicate-set-field
--       statusline.section_location = function()
--         return '%2l:%-2v'
--       end

--       -- ... and there is more!
--       --  Check out: https://github.com/echasnovski/mini.nvim
--     end,
--   },


--   -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
--   -- init.lua. If you want these files, they are in the repository, so you can just download them and
--   -- place them in the correct locations.

--   -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--   --
--   --  Here are some example plugins that I've included in the Kickstart repository.
--   --  Uncomment any of the lines below to enable them (you will need to restart nvim).
--   --
--   -- require 'kickstart.plugins.debug',
--   -- require 'kickstart.plugins.indent_line',
--   -- require 'kickstart.plugins.lint',
--   -- require 'kickstart.plugins.autopairs',
--   -- require 'kickstart.plugins.neo-tree',
--   -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

--   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--   --    This is the easiest way to modularize your config.
--   --
--   --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--   --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
--   -- { import = 'custom.plugins' },
-- }, {
--   ui = {
--     -- If you are using a Nerd Font: set icons to an empty table which will use the
--     -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
--     icons = vim.g.have_nerd_font and {} or {
--       cmd = '⌘',
--       config = '🛠',
--       event = '📅',
--       ft = '📂',
--       init = '⚙',
--       keys = '🗝',
--       plugin = '🔌',
--       runtime = '💻',
--       require = '🌙',
--       source = '📄',
--       start = '🚀',
--       task = '📌',
--       lazy = '💤 ',
--     },
--   },
-- })

-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
