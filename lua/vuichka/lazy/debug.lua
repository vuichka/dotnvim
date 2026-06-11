-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'mfussenegger/nvim-dap',
		},
		opts = {
			automatic_installation = true,
			ensure_installed = {
				'delve',
			},
		},
	}, {
	'mfussenegger/nvim-dap',
	dependencies = {
		-- Creates a beautiful debugger UI
		'rcarriga/nvim-dap-ui',
		"theHamsta/nvim-dap-virtual-text",

		-- Required dependency for nvim-dap-ui
		'nvim-neotest/nvim-nio',

		-- Installs the debug adapters for you
		'williamboman/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',

		-- Add your own debuggers here
		'leoluz/nvim-dap-go',
	},
	config = function()
		local dap = require 'dap'
		local dapui = require("dapui")
		dapui.setup({})
		require("nvim-dap-virtual-text").setup({})


		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Debug: Start/Continue' })
		vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
		vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
		vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'Debug: Step Out' })
		vim.keymap.set('n', '<F10>', dap.terminate, { desc = "Debug: Terminate" })

		vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
		vim.keymap.set('n', 'gb', dap.run_to_cursor, { desc = 'Debug: Run To Cursor' })

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)



		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close
		dap.set_log_level("ERROR")

		dap.configurations.go = { {
			type = "go",
			name = "Debug access",
			request = "launch",
			program = "${workspaceFolder}/cmd/access/main.go",
			console = "integratedTerminal",
			envFile = ".env",
			env = {},
		} }

		dap.adapters.go = {
			type = "server",
			port = 38697,
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:38697" },
			},
			enrich_config = function(finalConfig, on_config)
				local final_config = vim.deepcopy(finalConfig)

				if not final_config.env then
					final_config.env = {}
				end

				if final_config.envFile then
					local env = GetEnvsFromEnvFile(final_config.envFile)
					if not env then
						print("File not found " .. final_config.envFile)
					else
						for key, value in pairs(env) do
							final_config.env[key] = value
						end
					end
				end

				if final_config["type"] == "go" then
					final_config["outputMode"] = "remote"
				end

				on_config(final_config)
			end
		}
	end
},
}
