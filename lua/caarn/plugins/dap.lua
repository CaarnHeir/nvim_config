return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Runs preLaunchTasks if present
		"stevearc/overseer.nvim",
	},

	config = function()
		-- Signs
		local sign = vim.fn.sign_define

		local dap_round_groups = { "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }
		for _, group in pairs(dap_round_groups) do
			sign(group, { text = "●", texthl = group })
		end

		local dap = require("dap")

		-- Adapters
		-- C, C++, Rust
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "codelldb",
				args = { "--port", "${port}" },
			},
		}
		-- JS, TS
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "js-debug-adapter",
				args = { "${port}" },
			},
		}
		-- Godot
		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}
		--C#
		dap.adapters.coreclr = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		-- Configurations
		-- Usually prefer setting up via launch.json
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		-- Godot
		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch Scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}
		dap.configurations.cpp = {
			{
				type = "codelldb",
				request = "launch",
				name = "Launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				-- args = {}--[[ , ]]
			},
		}
		-- dap.configurations.rust = dap.configurations.cpp
		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function() -- Ask the user what executable wants to debug
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/program", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},
				initCommands = function() -- add rust types support (optional)
					-- Find out where to look for the pretty printer Python module
					local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

					local script_import = 'command script import "'
						.. rustc_sysroot
						.. '/lib/rustlib/etc/lldb_lookup.py"'
					local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

					local commands = {}
					local file = io.open(commands_file, "r")
					if file then
						for line in file:lines() do
							table.insert(commands, line)
						end
						file:close()
					end
					table.insert(commands, 1, script_import)

					return commands
				end,
			},
		}
		-- Dart / Flutter
		dap.adapters.dart = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
			args = { "dart" },
		}
		dap.adapters.flutter = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
			args = { "flutter" },
		}
		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch dart",
				dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
				flutterSdkPath = "/opt/flutter", -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
			{
				type = "flutter",
				request = "launch",
				name = "Launch flutter",
				dartSdkPath = "/opt/flutter/bin/cache/dart-sdk/", -- ensure this is correct
				flutterSdkPath = "/opt/flutter", -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
		}

		-- Kotlin
		-- Kotlin projects have very weak project structure conventions.
		-- You must manually specify what the project root and main class are.
		dap.adapters.kotlin = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/kotlin-debug-adapter",
		}
		dap.configurations.kotlin = {
			{
				type = "kotlin",
				request = "launch",
				name = "Launch kotlin program",
				projectRoot = "${workspaceFolder}/app", -- ensure this is correct
				mainClass = "AppKt", -- ensure this is correct
			},
		}

		-- Javascript / Typescript (firefox)
		dap.adapters.firefox = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
		}
		dap.configurations.typescript = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:4200", -- Write the actual URL of your project.
				webRoot = "${workspaceFolder}",
				firefoxExecutable = "/usr/bin/firefox",
			},
		}
		dap.configurations.javascript = dap.configurations.typescript
		dap.configurations.javascriptreact = dap.configurations.typescript
		dap.configurations.typescriptreact = dap.configurations.typescript

		-- Javascript / Typescript (chromium)
		-- If you prefer to use this adapter, comment the firefox one.
		-- But to use this adapter, you must manually run one of these two, first:
		-- * chromium --remote-debugging-port=9222 --user-data-dir=remote-profile
		-- * google-chrome-stable --remote-debugging-port=9222 --user-data-dir=remote-profile
		-- After starting the debugger, you must manually reload page to get all features.
		-- dap.adapters.chrome = {
		--  type = 'executable',
		--  command = vim.fn.stdpath('data')..'/mason/bin/chrome-debug-adapter',
		-- }
		-- dap.configurations.typescript = {
		--  {
		--   name = 'Debug with Chromium',
		--   type = "chrome",
		--   request = "attach",
		--   program = "${file}",
		--   cwd = vim.fn.getcwd(),
		--   sourceMaps = true,
		--   protocol = "inspector",
		--   port = 9222,
		--   webRoot = "${workspaceFolder}"
		--  }
		-- }
		-- dap.configurations.javascript = dap.configurations.typescript
		-- dap.configurations.javascriptreact = dap.configurations.typescript
		-- dap.configurations.typescriptreact = dap.configurations.typescript
	end,
}
