return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- "navarasu/onedark.nvim",
	-- name = "onedark",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
		})
		vim.cmd([[colorscheme catppuccin]])
	end,
}
-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	build = ":CatppuccinCompile",
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			highlight_overrides = {
-- 				all = function()
-- 					return {
-- 						DiagnosticVirtualTextError = { bg = "NONE" },
-- 						DiagnosticVirtualTextWarn = { bg = "NONE" },
-- 						DiagnosticVirtualTextInfo = { bg = "NONE" },
-- 						DiagnosticVirtualTextHint = { bg = "NONE" },
-- 						IblScope = { link = "IblIndent" },
-- 					}
-- 				end,
-- 			},
-- 			term_colors = true,
-- 			compile = {
-- 				enabled = true,
-- 				path = vim.fn.stdpath("cache") .. "/catppuccin",
-- 			},
-- 			integrations = {
-- 				telescope = true,
-- 				mason = true,
-- 				neogit = true,
-- 				gitsigns = true,
-- 				symbols_outline = true,
-- 				markdown = true,
-- 				cmp = true,
-- 				treesitter = true,
-- 				which_key = true,
-- 				indent_blankline = {
-- 					enabled = true,
-- 				},
-- 				nvimtree = {
-- 					transparent_panel = true,
-- 				},
-- 				native_lsp = {
-- 					enabled = true,
-- 				},
-- 			},
-- 			flavour = "macchiato",
-- 		})
