--set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","
local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

--BufferLine
keymap.set(
	"n",
	"<leader>bl",
	"<cmd>BufferLineCloseLeft<CR>",
	{ desc = "Close all buffers to the left of current buffer" }
)
keymap.set(
	"n",
	"<leader>br",
	"<cmd>BufferLineCloseRight<CR>",
	{ desc = "Close all buffers to the right of current buffer" }
)

--Trouble mappings
keymap.set(
	"n",
	"<leader>tr",
	"<cmd>Trouble diagnostics toggle filter.buf=0 win.position=right win.size.width=.4<cr>",
	{ silent = true, noremap = true }
)
-- keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
-- keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
keymap.set(
	"n",
	"<leader>xx",
	"<cmd>Trouble lsp toggle focus=false win.position=right win.size.width=.4<cr>",
	{ silent = true, noremap = true }
)
-- keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
-- keymap.set("n", "<leader>tr", "<cmd>TroubleToggle lsp_referencesfffffff<cr>", { silent = true, noremap = true })

--Debugger
keymap.set("n", "<leader>dt", function()
	require("dapui").toggle()
end, { noremap = true })
keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
keymap.set("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
keymap.set("n", "<leader>df", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
keymap.set("n", "<leader>dr", ":RustLsp debuggables<CR>", { noremap = true })
keymap.set("n", "<leader>do", ":lau require'dap'.step_over()<CR>", { noremap = true })
keymap.set("n", "<leader>di", ":lau require'dap'.step_into()<CR>", { noremap = true })
keymap.set("n", "<leader>du", ":lau require'dap'.step_back()<CR>", { noremap = true })

--Harpoon
keymap.set("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", { noremap = true })
keymap.set("n", "<leader>hm", "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = "Mark file with harpoon" })
keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })
keymap.set("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = "Go to previous harpoon mark" })
keymap.set(
	"n",
	"<leader>ht",
	"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
	{ desc = "Toggle the Harpoon Menu" }
)

--todo comment key maps
keymap.set("n", "<leader>tl", "<cmd>TodoTelescope<CR>", { desc = "Todo Telescope" })
keymap.set("n", "<leader>tt", "<cmd>TodoTrouble<CR>", { desc = "Todo Trouble" })

-- Fterm
-- vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('FTerm').toggle()<CR>", {noremap=true})
-- vim.api.nvim_set_keymap("t", "<leader>tt", '<C-\\><C-n>:lua require("FTerm").toggle()<CR>', {noremap=true})

--Autosession
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

--Formatting REFERENCE ONLY
--keymap.set({ "n", "v" }, "<leader>mp", function()

--Linting REFERENCE ONLY
--<leader>l

--NvimTree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

--Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

--LAZY GIT REFERENCE ONLY
---<leader>lg

--Maximizer REFERNCE ONLy
--<leader>sm

--*******************************************
--General Keymaps
--*******************************************

--Moving Lines Up or Down
keymap.set({ "n", "v" }, "mk", "<cmd>m-2<cr>", { desc = "move line up one" })
keymap.set({ "n", "v" }, "mj", "<cmd>m+1<cr>", { desc = "move line down one" })

--OIL keymaps
keymap.set({ "n" }, "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory" })
