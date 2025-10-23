-- manually LOAD colorscheme below
-- colorscheme
-- vim.cmd.colorscheme("tokyonight-moon")

-- numbers colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "yellow", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "yellow", bold = false })

-- comment colors
vim.api.nvim_set_hl(0, "Comment", { fg = "gray" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- NOTE: 
-- these options below are only relevant if you are writing C code 
-- according to the "norminette" code norms set by 42 school
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- uncommnent the 2 lines below if you want whitespaces to have character representations
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Plugin Keymaps ]]

-- CopilotChat
-- Keybind to open Copilot chat window
vim.api.nvim_set_keymap('n', '<leader>cp', ':CopilotChatOpen<CR>', { noremap = true, silent = true })

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")


-- Exit terminal mode in the builtin terminal with 'ESC+ESC' instead of 'CTRL+\ CTRL+n'
--  NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
--  or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier. `:help wincmd` for window commands
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Plugin Keymaps ]]

-- [Spectre]
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

-- [ LSP ]
-- Keybind to enable on-screen diagnostics
vim.api.nvim_set_keymap('n', '<leader>lt', ':lua vim.diagnostic.config({virtual_text=true})<CR>', { noremap = true, silent = true })

-- Keybind to disable virtual text for diagnostics
vim.api.nvim_set_keymap('n', '<leader>lf', ':lua vim.diagnostic.config({virtual_text=false})<CR>', { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [CopilotChat]
-- Keybind to open Copilot chat window
vim.api.nvim_set_keymap('n', '<leader>cp', ':CopilotChatOpen<CR>', { noremap = true, silent = true, desc = "toggle [C]o[P]ilot Chat Window"})
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
