return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		local builtin = require("telescope.builtin")
		telescope.load_extension("fzf")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>pm", builtin.marks, {})
		vim.keymap.set("n", "<leader>ps", builtin.grep_string, {})
		vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})

		local vault_path = "/Users/malewicz/Documents/Obsidian Vault/"
		vim.keymap.set("n", "<leader>on", function()
			vim.cmd("vsplit")
			vim.cmd("tcd " .. vault_path)
			builtin.find_files({
				cwd = vault_path,
			})
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>oo", function()
			vim.cmd("tcd " .. vault_path)
			builtin.find_files({
				cwd = vault_path,
			})
		end, { noremap = true, silent = true })
	end,
}
