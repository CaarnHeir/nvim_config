return {
	"shortcuts/no-neck-pain.nvim",
	config = function()
		require("no-neck-pain").setup({
			buffers = {
				right = {
					enabled = false,
				},
				scratchPad = {
					-- set to `false` to
					-- disable auto-saving
					enabled = true,
					-- set to `nil` to default
					-- to current working directory
					location = "~/Documents/",
				},
				bo = {
					filetype = "md",
				},
			},
		})
	end,
}
