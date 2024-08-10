return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		require("bufferline").setup({
			--highlights = require("kanagawa.groups.integrations.bufferline").get(),
			options = {
				close_command = "bp|sp|bn|bd! %d",
				right_mouse_command = "bp|sp|bn|bd! %d",
				left_mouse_command = "buffer %d",
				buffer_close_icon = "",
				modified_icon = "",
				close_icon = "",
				show_close_icon = false,
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 14,
				max_prefix_length = 13,
				tab_size = 10,
				show_tab_indicators = true,
				indicator = {
					style = "underline",
				},
				enforce_regular_tabs = false,
				view = "multiwindow",
				show_buffer_close_icons = true,
				separator_style = "thin",
				-- separator_style = "slant",
				always_show_bufferline = true,
				diagnostics = false,
				themable = true,
			},
		})
	end,
	opts = {
		options = {
			mode = "tabs",
			offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		},
	},
	color_icons = true,
	get_element_icon = function(element)
		local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
		return icon, hl
	end,
	hover = {
		enabled = true,
		delay = 200,
		reveal = { "close" },
	},
}
