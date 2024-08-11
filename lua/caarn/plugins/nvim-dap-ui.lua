return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	event = "VeryLazy",
	opts = {
		icons = {
			expanded = "󰅀",
			collapsed = "󰅂",
			current_frame = "󰅂",
		},
		-- layouts = {
		-- 	{
		-- 		elements = {
		-- 			{ id = "scopes", size = 0.5 },
		-- 			{ id = "watches", size = 0.5 },
		-- 		},
		-- 		size = 40,
		-- 		position = "left",
		-- 	},
		-- 	{
		-- 		elements = { "console" },
		-- 		position = "bottom",
		-- 		size = 15,
		-- 	},
		-- },
		-- controls = {
		-- enabled = false,
		-- },
		floating = {
			border = "rounded",
		},
		-- render = {
		-- indent = 2,
		-- Hide variable types as C++'s are verbose
		-- max_type_length = 0,
		-- },
	},
	config = function(_, opts)
		local dap, dapui = require("dap"), require("dapui")

		-- Open and Close windows automatically
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		dapui.setup(opts)
	end,
}
