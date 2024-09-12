-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	"mfussenegger/nvim-dap",
	lazy = "SuperLazy",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		--"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			-- Basic debugging keymaps, feel free to change to your liking!
			{ "<F5>", dap.continue, desc = "Debug: Start/Continue" },
			{ "<F1>", dap.step_into, desc = "Debug: Step Into" },
			{ "<F2>", dap.step_over, desc = "Debug: Step Over" },
			{ "<F3>", dap.step_out, desc = "Debug: Step Out" },
			{ "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
			{
				"<leader>B",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ "<F7>", dapui.toggle, desc = "Debug: See last session result." },
			{
				"<leader>?",
				function()
					dapui.eval(nil, { enter = true })
				end,
				desc = "Debug: inspect element",
			},
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				"netcoredbg",
				"cpptools",
				"js-debug-adapter",
				"codelldb",
				-- Update this to ensure that you have the debuggers for the langs you want
				--'delve',
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
			vim.cmd("colorscheme " .. vim.g.colors_name)
		end
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- Install Python specific config
		require("dap-python").setup("python3")
		--
		-- Install golang specific config
		-- require("dap-go").setup({
		--	delve = {
		--		-- On Windows delve must be run attached or it crashes.
		--		-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
		--		detached = vim.fn.has("win32") == 0,
		--	},
		--})
	end,
}

-- return {

-- 	"mfussenegger/nvim-dap",
-- 	dependencies = {
-- 		-- Runs preLaunchTasks if present
-- 		"stevearc/overseer.nvim",
-- 	},
--
-- 	config = function()
-- 		-- Signs
-- 		local sign = vim.fn.sign_define
--
-- 		local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
-- 		for _, group in pairs(dap_round_groups) do
-- 			sign(group, { text = "●", texthl = group })
-- 		end
--
-- 		local dap = require("dap")
--
-- 		-- dap.adapters.netcoredbg = {
-- 		-- 	type = "executable",
-- 		-- 	command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
-- 		-- 	args = { "--interpreter=vscode" },
-- 		-- 	options = {
-- 		-- 		detached = false,
-- 		-- 	},
-- 		-- }
-- 		dap.configurations.cs = {
-- 			{
-- 				type = "coreclr",
-- 				name = "launch - netcoredbg",
-- 				request = "launch",
-- 				program = function()
-- 					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
-- 				end,
-- 			},
-- 		}
-- 		dap.adapters.coreclr = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
-- 			args = { "--interpreter=vscode" },
-- 		}
-- 		dap.adapters.netcoredbg = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
-- 			args = { "--interpreter=vscode" },
-- 		}
--
-- 		--	Adapters
-- 		-- C, C++, Rust
-- 		dap.adapters.codelldb = {
-- 			type = "server",
-- 			port = "${port}",
-- 			executable = {
-- 				command = "codelldb",
-- 				args = { "--port", "${port}" },
-- 			},
-- 		}
-- 		-- JS, TS
-- 		dap.adapters["pwa-node"] = {
-- 			type = "server",
-- 			host = "localhost",
-- 			port = "${port}",
-- 			executable = {
-- 				command = "js-debug-adapter",
-- 				args = { "${port}" },
-- 			},
-- 		}
-- 		-- Godot
-- 		dap.adapters.godot = {
-- 			type = "server",
-- 			host = "127.0.0.1",
-- 			port = 6006,
-- 		}
-- 		--C#
-- 		dap.adapters.coreclr = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
-- 			args = { "--interpreter=vscode" },
-- 		}
--
-- 		-- Configurations
-- 		-- Usually prefer setting up via launch.json
-- 		dap.configurations.cs = {
-- 			{
-- 				type = "netcoredbg",
-- 				name = "Launch file",
-- 				request = "launch",
-- 				program = function()
-- 					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
-- 				end,
-- 				cwd = "${workspaceFolder}",
-- 			},
-- 		}
-- 		dap.configurations.gdscript = {
-- 			{
-- 				type = "godot",
-- 				request = "launch",
-- 				name = "Launch Scene",
-- 				project = "${workspaceFolder}",
-- 				launch_scene = true,
-- 			},
-- 		}
-- 		dap.configurations.cpp = {
-- 			{
-- 				type = "codelldb",
-- 				request = "launch",
-- 				name = "Launch",
-- 				program = function()
-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 				end,
-- 				cwd = "${workspaceFolder}",
-- 				stopOnEntry = false,
-- 				-- args = {}--[[ , ]]
-- 			},
-- 		}
-- 		-- dap.configurations.rust = dap.configurations.cpp
-- 		dap.configurations.rust = {
-- 			{
-- 				name = "Launch",
-- 				type = "codelldb",
-- 				request = "launch",
-- 				program = function() -- Ask the user what executable wants to debug
-- 					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
-- 				end,
-- 				cwd = "${workspaceFolder}",
-- 				stopOnEntry = false,
-- 				args = {},
-- 				initCommands = function() -- add rust types support (optional)
-- 					-- Find out where to look for the pretty printer Python module
-- 					local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
--
-- 					local script_import = 'command script import "'
-- 						.. rustc_sysroot
-- 						.. '/lib/rustlib/etc/lldb_lookup.py"'
-- 					local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"
--
-- 					local commands = {}
-- 					local file = io.open(commands_file, "r")
-- 					if file then
-- 						for line in file:lines() do
-- 							table.insert(commands, line)
-- 						end
-- 						file:close()
-- 					end
-- 					table.insert(commands, 1, script_import)
--
-- 					return commands
-- 				end,
-- 			},
-- 		}
-- 		-- Dart / Flutter
-- 		dap.adapters.dart = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
-- 			args = { "dart" },
-- 		}
-- 		dap.adapters.flutter = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
-- 			args = { "flutter" },
-- 		}
-- 		dap.configurations.dart = {
-- 			{
-- 				type = "dart",
-- 				request = "launch",
-- 				name = "Launch dart",
-- 				dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
-- 				flutterSdkPath = "/opt/flutter", -- ensure this is correct
-- 				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
-- 				cwd = "${workspaceFolder}",
-- 			},
-- 			{
-- 				type = "flutter",
-- 				request = "launch",
-- 				name = "Launch flutter",
-- 				dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
-- 				flutterSdkPath = "/opt/flutter", -- ensure this is correct
-- 				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
-- 				cwd = "${workspaceFolder}",
-- 			},
-- 		}
--
-- 		-- Kotlin
-- 		-- Kotlin projects have very weak project structure conventions.
-- 		-- You must manually specify what the project root and main class are.
-- 		dap.adapters.kotlin = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
-- 		}
-- 		dap.configurations.kotlin = {
-- 			{
-- 				type = "kotlin",
-- 				request = "launch",
-- 				name = "Launch kotlin program",
-- 				projectRoot = "${workspaceFolder}/app", -- ensure this is correct
-- 				mainClass = "AppKt", -- ensure this is correct
-- 			},
-- 		}
--
-- 		-- Javascript / Typescript (firefox)
-- 		dap.adapters.firefox = {
-- 			type = "executable",
-- 			command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
-- 		}
-- 		dap.configurations.typescript = {
-- 			{
-- 				name = "Debug with Firefox",
-- 				type = "firefox",
-- 				request = "launch",
-- 				reAttach = true,
-- 				url = "http://localhost:4200", -- Write the actual URL of your project.
-- 				webRoot = "${workspaceFolder}",
-- 				firefoxExecutable = "/usr/bin/firefox",
-- 			},
-- 		}
--
-- 		vim.g.dotnet_build_project = function()
-- 			local default_path = vim.fn.getcwd() .. "/"
-- 			if vim.g["dotnet_last_proj_path"] ~= nil then
-- 				default_path = vim.g["dotnet_last_proj_path"]
-- 			end
-- 			local path = vim.fn.input("Path to your *proj file", default_path, "file")
-- 			vim.g["dotnet_last_proj_path"] = path
-- 			local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
-- 			print("")
-- 			print("Cmd to execute: " .. cmd)
-- 			local f = os.execute(cmd)
-- 			if f == 0 then
-- 				print("\nBuild: ✔️ ")
-- 			else
-- 				print("\nBuild: ❌ (code: " .. f .. ")")
-- 			end
-- 		end
--
-- 		vim.g.dotnet_get_dll_path = function()
-- 			local request = function()
-- 				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
-- 			end
--
-- 			if vim.g["dotnet_last_dll_path"] == nil then
-- 				vim.g["dotnet_last_dll_path"] = request()
-- 			else
-- 				if
-- 					vim.fn.confirm(
-- 						"Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
-- 						"&yes\n&no",
-- 						2
-- 					) == 1
-- 				then
-- 					vim.g["dotnet_last_dll_path"] = request()
-- 				end
-- 			end
--
-- 			return vim.g["dotnet_last_dll_path"]
-- 		end
--
-- 		local config = {
-- 			{
-- 				type = "coreclr",
-- 				name = "launch - netcoredbg",
-- 				request = "launch",
-- 				program = function()
-- 					if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
-- 						vim.g.dotnet_build_project()
-- 					end
-- 					return vim.g.dotnet_get_dll_path()
-- 				end,
-- 			},
-- 		}
--
-- 		dap.configurations.cs = config
-- 		dap.configurations.fsharp = config
--
-- 		dap.configurations.javascript = dap.configurations.typescript
-- 		dap.configurations.javascriptreact = dap.configurations.typescript
-- 		dap.configurations.typescriptreact = dap.configurations.typescript
--
-- 		-- Javascript / Typescript (chromium)
-- 		-- If you prefer to use this adapter, comment the firefox one.
-- 		-- But to use this adapter, you must manually run one of these two, first:
-- 		-- * chromium --remote-debugging-port=9222 --user-data-dir=remote-profile
-- 		-- * google-chrome-stable --remote-debugging-port=9222 --user-data-dir=remote-profile
-- 		-- After starting the debugger, you must manually reload page to get all features.
-- 		-- dap.adapters.chrome = {
-- 		--  type = 'executable',
-- 		--  command = vim.fn.stdpath('data')..'/mason/bin/chrome-debug-adapter',
-- 		-- }
-- 		-- dap.configurations.typescript = {
-- 		--  {
-- 		--   name = 'Debug with Chromium',
-- 		--   type = "chrome",
-- 		--   request = "attach",
-- 		--   program = "${file}",
-- 		--   cwd = vim.fn.getcwd(),
-- 		--   sourceMaps = true,
-- 		--   protocol = "inspector",
-- 		--   port = 9222,
-- 		--   webRoot = "${workspaceFolder}"
-- 		--  }
-- 		-- }
-- 		-- dap.configurations.javascript = dap.configurations.typescript
-- 		-- dap.configurations.javascriptreact = dap.configurations.typescript
-- 		-- dap.configurations.typescriptreact = dap.configurations.typescript
-- 	end,
-- }
