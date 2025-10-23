-- NOTE: Run `:checkhealth` to check if your system is set-up properly
-- Not every warning is a 'must-fix' in `:checkhealth`

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  NOTE: set true if a Nerd Font is installed
vim.g.have_nerd_font = false

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- the function BELOW is where you will add your NeoVim plugins, through the Lazy Package Manager
-- to ADD a new plugin just create a .lua file for it inside the `lua/` directory
-- in the file paste inside a return statement the config contents of the plugin
-- (check the other .lua files for exemples) then import it like I did below;
-- if the file is under a dir then `plugins.[dir].[plugin_file_name]`, else don't write the [dir] part.
-- to DISABLE a plugin just comment the line where the plugin is imported

require("lazy").setup({
--  NOTE: if you have any doubts about what a plugin is doing or how to work with it
--		  try running `:help [plugin_name]`

--	Basic Utitlity Plugins:

	-- adds git related signs to the gutter and utilities for managing changes
	{ import = "plugins.utils.gitsigns" },

	-- adds a guiding line in indented blocks
	{ import = "plugins.utils.indent_line" },

	-- adds a variety of helpful tools to NeoVim, check file for keybinds and github
	{ import = "plugins.utils.mini" },

	-- file system browser, open with [\] key
	{ import = "plugins.utils.neo-tree" },

	-- must have language parsing tool and library
	{ import = "plugins.utils.nvim-treesitter" },

	-- great fuzzy finder, try `:help Telescope` for more info
	{ import = "plugins.utils.telescope" },

	-- adds a bunch of helpful keywords like the NOTE that I've been using, check plugin file to see all the available ones
	{ import = "plugins.utils.todo-comments" },

	-- great plugin if you're still learning neovim keybinds,
	-- shows you follow-up keystrokes based what key you pressed first
	{ import = "plugins.utils.which-key" },

	-- amazing "search and replace tool", use with caution though
	-- Open and use Spectre inside a codebase with the keybind '<space>S'
	-- Open and use Spectre inside a single file with '<space>sp'
	-- Change every search result at once with '<space>R'
	-- Change the search result your cursor is on with '<space>rc'
	{ import = "plugins.util.spectre"},

	-- this plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
	-- might run into issues with Norminette so it is disabled by default
	-- { import = "plugins.utils.vim-sleuth" },

--	42 School Related Plugins:
	{ import = "plugins.42.42-norminette" },
	-- keybinds inside plugin file
	{ import = "plugins.42.42-header" },
	--  TODO: add your user and email inside the plugin file

--	Theme Related Plugins:
	-- PREVIEW and LOAD many themes from the nvim theme repo with ':Switcheroo'
	{ import = "plugins.themes.switcheroo" },
	-- LOAD themes you already have saved in stash
	{ import = "plugins.themes.themery" },
	--	if you want to add a theme locally add it to the `lua/plugins/themes/theme-stash.lua` 
	--	and load it in the vim-options file
	{ import = "plugins.themes.theme-stash" },

--	Dashboard Plugins:
	{ import = "plugins.dashboard.snacks" },
	-- loads your previous session by pressing 's' when dashboard is loaded
	{ import = "plugins.dashboard.persistence" },

--	LSP Related Plugins:
	{ import = "plugins.LSP.lazydev" },
	-- NOTE:
	-- the LSP config in the file below is what works for me
	-- I commented a lot of functionalities, check the file and edit to your liking
	-- LSP related keybinds in the plugin and also in the vim-options file
	{ import = "plugins.LSP.nvim-lspconfig" }
	--	auto-format and auto-completion plugins below;
	--	I personally don't use them so if you want to load them uncomment the 2 imports below
	--	ps: they might need some tweaking in their config functions
	--	{ import = "plugins.LSP.conform_autoformat" },
	--	{ import = "plugins.LSP.nvim-cmp_autocompletion" },

--	AI Related Plugins: NOTE: run `:Copilot auth` to to sync your Copilot account with the plugin

	-- { import = "plugins.AI.copilot" },
	-- modified version of the original copilot plugin 
	-- { import = "plugins.AI.copilotChat" }
	-- CoPilot vscode-like chat window, check file and github on how to use

}, {
	ui = {
	-- If you are using a Nerd Font: set icons to an empty table which will use the
	-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

require("vim-options")
